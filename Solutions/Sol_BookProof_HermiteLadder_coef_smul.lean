-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.coef_smul
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (c : ℂ) (v : L2d d) : coef a (c • v) = c * coef a v := inner_smul_right _ _ _
