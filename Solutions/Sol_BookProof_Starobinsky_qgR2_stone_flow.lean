-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.qgR2_stone_flow
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Theorems.Thm_BookProof_Starobinsky_mulSymbolDomain_dense
import Theorems.Thm_BookProof_Starobinsky_qgR2Mode_symmetric
import Theorems.Thm_BookProof_Starobinsky_qgR2Mode_esa
open BookProof.Starobinsky












open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section





















variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint L2Nat) (U : ℝ → (L2Nat →L[ℂ] L2Nat)),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (qgR2ModeHamiltonian a b M alpha Rc)
      (mulSymbolDomain_dense _) (qgR2Mode_symmetric a b M alpha Rc)
      (qgR2Mode_esa a b M alpha Rc)
