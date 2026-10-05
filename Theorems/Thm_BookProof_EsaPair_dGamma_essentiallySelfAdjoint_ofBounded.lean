-- Generated from ChapterEsaPairDGamma.lean — theorem BookProof.EsaPair.dGamma_essentiallySelfAdjoint_ofBounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DirectSumEsa
open BookProof.TensorCore
open BookProof.EsaPair

variable {Hs : IPSpace} (P : ESAPair Hs)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaPair.dGamma_essentiallySelfAdjoint_ofBounded (Hs : IPSpace)
    (B : (⊤ : Submodule ℂ Hs.carrier) →ₗ[ℂ] Hs.carrier) (hB : SymmetricOn ⊤ B) {C : ℝ}
    (hC0 : 0 ≤ C) (hC : ∀ a : (⊤ : Submodule ℂ Hs.carrier), ‖B a‖ ≤ C * ‖(a : Hs.carrier)‖)
    (D : Submodule ℂ Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs ⊤ D n))
      (dGammaCoreOp Hs ⊤ B D) := by sorry
