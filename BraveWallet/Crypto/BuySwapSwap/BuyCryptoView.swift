// Copyright 2021 The Brave Authors. All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import SwiftUI
import BraveUI
import BraveCore
import Shared

struct BuyCryptoView: View {
  var tokenRegistry: BraveWalletERCTokenRegistry
  var keyringStore: KeyringStore
  var networkStore: NetworkStore
  @State var currentBuyToken: BraveWallet.ERCToken?
  
  @Environment(\.presentationMode) @Binding private var presentationMode
  
    var body: some View {
      NavigationView {
        Form {
          Section(
            header: AccountPicker(
              keyringStore: keyringStore,
              networkStore: networkStore,
              account: .constant(keyringStore.keyring.accountInfos.first!)
            )
              .listRowBackground(Color.clear)
              .resetListHeaderStyle()
              .padding(.top)
              .padding(.bottom, -16) // Get it a bit closer
          ) {
          }
          Section(
            header: WalletListHeaderView(title: Text("Buy"))
          ) {
            NavigationLink(destination: AssetSearchView(tokenRegistry: tokenRegistry,
                                                        keyringStore: keyringStore,
                                                        networkStore: networkStore,
                                                        assetAction: .buy)) {
              HStack {
                Circle()
                  .frame(width: 26, height: 26)
                Text(currentBuyToken?.name ?? "")
                  .font(.title3.weight(.semibold))
                  .foregroundColor(Color(.braveLabel))
                Spacer()
                Text("1.2832")
                  .font(.footnote)
                  .foregroundColor(Color(.secondaryBraveLabel))
              }
              .padding(.vertical, 8)
            }
            .listRowBackground(Color(.secondaryBraveGroupedBackground))
          }
          Section(
            header: WalletListHeaderView(title: Text("Enter amount"))
          ) {
            HStack {
              TextField("Amount", text: .constant(""))
                .keyboardType(.decimalPad)
              Spacer()
              Text("= 0 USD")
                .font(.footnote)
                .foregroundColor(Color(.secondaryBraveLabel))
            }
          }
          .listRowBackground(Color(.secondaryBraveGroupedBackground))
          Section(
            header: HStack {
              Spacer()
              Button(action: { }) {
                Text("Preview")
              }
                .buttonStyle(BraveFilledButtonStyle(size: .normal))
              Spacer()
            }
              .resetListHeaderStyle()
              .listRowBackground(Color(.clear))
          ) {
          }
          .listRowBackground(Color(.secondaryBraveGroupedBackground))
        }
        .navigationTitle("Buy")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarLeading) {
            Button(action: {
              presentationMode.dismiss()
            }) {
              Text(Strings.CancelString)
                .foregroundColor(Color(.braveOrange))
            }
          }
        }
      }
    }
}

//#if DEBUG
//struct BuyCryptoView_Previews: PreviewProvider {
//    static var previews: some View {
//      BuyCryptoView(
//        keyringStore: .previewStoreWithWalletCreated,
//        ethNetworkStore: .previewStore
//      )
//      .previewColorSchemes()
//    }
//}
//#endif
