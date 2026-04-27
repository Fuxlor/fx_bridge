if Config.Locale ~= 'fr' then return end

Bridge.Locales = {
    -- Génériques
    ['error']           = 'Erreur',
    ['success']         = 'Succès',
    ['loading']         = 'Chargement...',
    ['confirm']         = 'Confirmer',
    ['cancel']          = 'Annuler',
    ['close']           = 'Fermer',
    ['yes']             = 'Oui',
    ['no']              = 'Non',

    -- Véhicules
    ['vehicle_spawned']         = 'Véhicule sorti du garage.',
    ['vehicle_stored']          = 'Véhicule rangé au garage.',
    ['vehicle_not_owned']       = 'Ce véhicule ne vous appartient pas.',
    ['vehicle_already_out']     = 'Ce véhicule est déjà sorti.',
    ['vehicle_damaged']         = 'Véhicule endommagé — remise en état recommandée.',
    ['vehicle_no_key']          = 'Vous n\'avez pas les clés de ce véhicule.',

    -- Argent
    ['insufficient_funds']      = 'Fonds insuffisants.',
    ['payment_success']         = 'Paiement effectué : %s $',
    ['payment_failed']          = 'Paiement échoué.',

    -- Garage
    ['garage_empty']            = 'Aucun véhicule dans ce garage.',
    ['garage_not_accessible']   = 'Ce garage n\'est pas accessible.',
    ['garage_vehicle_impounded'] = 'Ce véhicule est en fourrière.',

    -- Concessionnaire
    ['dealer_purchase_confirm'] = 'Acheter %s pour %s $ ?',
    ['dealer_purchased']        = 'Véhicule acheté avec succès !',
    ['dealer_out_of_stock']     = 'Ce véhicule est en rupture de stock.',

    -- Clés
    ['key_given']       = 'Clé donnée à %s.',
    ['key_received']    = '%s vous a donné les clés.',
    ['key_removed']     = 'Clé retirée.',
    ['keys_none']       = 'Vous n\'avez aucune clé.',
}
