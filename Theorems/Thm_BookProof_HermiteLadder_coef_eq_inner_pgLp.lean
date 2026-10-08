-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.coef_eq_inner_pgLp
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HermiteLadder



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteLadder.coef_eq_inner_pgLp (a : Fin d →₀ ℕ) (v : L2d d) :
    coef a v = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ * inner ℂ (pgLp (hermiteMv a)) v := by sorry
