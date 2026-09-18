-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.qgR2Mode_symmetric
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Theorems.Thm_BookProof_FarisLavine_mulSymbolOp_symmetric
open BookProof.Starobinsky



open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    SymmetricOn (mulSymbolDomain (qgModeSymbol a b (qgR2ModePotential M alpha Rc)))
      (qgR2ModeHamiltonian a b M alpha Rc) := mulSymbolOp_symmetric _ _ (fun _ => le_rfl)
