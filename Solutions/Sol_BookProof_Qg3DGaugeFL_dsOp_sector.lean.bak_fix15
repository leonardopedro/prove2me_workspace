-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.dsOp_sector
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
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
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) (i : ι) :
    ((dsOp H x : lp G 2) : ∀ i, G i) i = H i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ := rfl
