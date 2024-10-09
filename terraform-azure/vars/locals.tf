locals {
  tags = merge(
    data.azurerm_subscription.current.tags,
    {
      ApplicationID    = "1",
      ApplicationName  = "Azure Services",
      ApplicationOwner = "azure"
      Provisioner      = "az cli"
    }
  )
  tags_re = merge(
    data.azurerm_subscription.current.tags,
    data.azurerm_resource_group.myrg.tags,
    var.tags
  )
}