-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.op_squeezeState
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.op_squeezeState (i : Fin d) (α γ v : ℝ) (M : ℕ) :
    ((α : ℝ) : ℂ) • (X i * squeezeState i v M)
        + ((γ : ℝ) : ℂ) • pderiv i (squeezeState i v M)
      = coordCombo i (opCoef α γ v M) 1 M := by sorry
