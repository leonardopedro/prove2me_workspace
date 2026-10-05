-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.dGamma_essentiallySelfAdjoint_ofBounded
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_EsaPair_ESAPair_dGamma_essentiallySelfAdjoint
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution (Hs : IPSpace)
    (B : (⊤ : Submodule ℂ Hs.carrier) →ₗ[ℂ] Hs.carrier) (hB : SymmetricOn ⊤ B) {C : ℝ}
    (hC0 : 0 ≤ C) (hC : ∀ a : (⊤ : Submodule ℂ Hs.carrier), ‖B a‖ ≤ C * ‖(a : Hs.carrier)‖)
    (D : Submodule ℂ Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs ⊤ D n))
      (dGammaCoreOp Hs ⊤ B D) := (ESAPair.ofBounded Hs B hB hC0 hC D hdense).dGamma_essentiallySelfAdjoint
