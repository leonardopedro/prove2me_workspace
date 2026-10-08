-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.magPoly_abelian
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite
open BookProof.YangMillsAbelianNoGap



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

theorem BookProof.YangMillsAbelianNoGap.magPoly_abelian (i : Fin 3) (a : Fin 8) :
    magPoly (fun _ _ _ => 0) i a
      = ∑ j : Fin 3, ∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • X (idxD j k a) := by sorry
