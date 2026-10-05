-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.dGamma_positiveExtension_eq_closure
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open BookProof.YangMillsFriedrichs
open BookProof.FockSchur

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.FockSchur.dGamma_positiveExtension_eq_closure (hK : SchurBound col K) (hherm : IsHermCol col)
    (hK0 : 0 ≤ K) {Dom : Submodule ℂ Fock} {A : Dom →ₗ[ℂ] Fock}
    (hA : IsPositiveSelfAdjointExtension (dGammaOp col) A) :
    Dom = clDom (dGammaOp col) ∧
      ∀ (x : Fock) (h : x ∈ Dom) (h' : x ∈ clDom (dGammaOp col)),
        A ⟨x, h⟩ = clExt (dGammaOp col) finiteOccupation_dense
          (dGammaOp_symmetricOn hherm) ⟨x, h'⟩ := by sorry
