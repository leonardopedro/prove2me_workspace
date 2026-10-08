-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.integral_comp_rotIso
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.QuadraticRotation



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.QuadraticRotation.integral_comp_rotIso {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (g : Vd d → ℂ) : ∫ x : Vd d, g (rotIso hO x) = ∫ y : Vd d, g y := by sorry
