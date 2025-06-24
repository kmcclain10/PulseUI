
-- Table: dealers
CREATE TABLE dealers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    subscription_tier TEXT CHECK (subscription_tier IN ('Basic', 'Pro', 'Enterprise')),
    status TEXT CHECK (status IN ('green', 'yellow', 'red')) DEFAULT 'yellow',
    created_at TIMESTAMP DEFAULT now()
);

-- Table: users (dealer staff)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    dealer_id UUID REFERENCES dealers(id),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT CHECK (role IN ('admin', 'sales', 'fi_manager')),
    created_at TIMESTAMP DEFAULT now()
);

-- Table: vehicles
CREATE TABLE vehicles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    dealer_id UUID REFERENCES dealers(id),
    vin TEXT UNIQUE NOT NULL,
    year INTEGER NOT NULL,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    trim TEXT,
    price NUMERIC,
    mileage INTEGER,
    condition TEXT CHECK (condition IN ('new', 'used')),
    status TEXT CHECK (status IN ('available', 'pending', 'sold')) DEFAULT 'available',
    images TEXT[], -- array of image URLs
    created_at TIMESTAMP DEFAULT now()
);

-- Table: leads
CREATE TABLE leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    vehicle_id UUID REFERENCES vehicles(id),
    dealer_id UUID REFERENCES dealers(id),
    name TEXT,
    email TEXT,
    phone TEXT,
    message TEXT,
    source TEXT,
    created_at TIMESTAMP DEFAULT now()
);

-- Table: desking_deals
CREATE TABLE desking_deals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    dealer_id UUID REFERENCES dealers(id),
    vehicle_id UUID REFERENCES vehicles(id),
    lead_id UUID REFERENCES leads(id),
    taxes NUMERIC,
    vsc NUMERIC,
    gap NUMERIC,
    optional_products JSONB,
    total_price NUMERIC,
    created_at TIMESTAMP DEFAULT now()
);
