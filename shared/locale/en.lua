if Config.Locale ~= 'en' then return end

Bridge.Locales = {
    -- Generic
    ['error']           = 'Error',
    ['success']         = 'Success',
    ['loading']         = 'Loading...',
    ['confirm']         = 'Confirm',
    ['cancel']          = 'Cancel',
    ['close']           = 'Close',
    ['yes']             = 'Yes',
    ['no']              = 'No',

    -- Vehicles
    ['vehicle_spawned']         = 'Vehicle taken out of the garage.',
    ['vehicle_stored']          = 'Vehicle stored in the garage.',
    ['vehicle_not_owned']       = 'This vehicle does not belong to you.',
    ['vehicle_already_out']     = 'This vehicle is already out.',
    ['vehicle_damaged']         = 'Vehicle damaged — repair recommended.',
    ['vehicle_no_key']          = 'You do not have the keys for this vehicle.',

    -- Money
    ['insufficient_funds']      = 'Insufficient funds.',
    ['payment_success']         = 'Payment made: $%s',
    ['payment_failed']          = 'Payment failed.',

    -- Garage
    ['garage_empty']            = 'No vehicles in this garage.',
    ['garage_not_accessible']   = 'This garage is not accessible.',
    ['garage_vehicle_impounded'] = 'This vehicle has been impounded.',

    -- Dealer
    ['dealer_purchase_confirm'] = 'Buy %s for $%s?',
    ['dealer_purchased']        = 'Vehicle purchased successfully!',
    ['dealer_out_of_stock']     = 'This vehicle is out of stock.',

    -- Keys
    ['key_given']       = 'Key given to %s.',
    ['key_received']    = '%s gave you the keys.',
    ['key_removed']     = 'Key removed.',
    ['keys_none']       = 'You have no keys.',
}
