-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.dsOp_number_conserving
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_sector
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) {n : ι}
    (hx : ∀ i, i ≠ n → ((x : lp G 2) : ∀ i, G i) i = 0) (i : ι) (hi : i ≠ n) :
    ((dsOp H x : lp G 2) : ∀ i, G i) i = 0 := by

  rw [dsOp_sector]
  have hz : (⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ : D i) = 0 := Subtype.ext (hx i hi)
  rw [hz, map_zero]
