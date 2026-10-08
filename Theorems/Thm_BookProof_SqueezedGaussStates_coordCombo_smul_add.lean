-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.coordCombo_smul_add
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.GaussCoordCombo
open BookProof.HermiteProductCore
open BookProof.SqueezedGaussStates



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}


theorem BookProof.SqueezedGaussStates.coordCombo_smul_add (i : Fin d) (c₁ c₂ : ℕ → ℝ) (α γ : ℝ) (p K : ℕ) :
    ((α : ℝ) : ℂ) • coordCombo i c₁ p K + ((γ : ℝ) : ℂ) • coordCombo i c₂ p K
      = coordCombo i (fun k => α * c₁ k + γ * c₂ k) p K := by sorry
