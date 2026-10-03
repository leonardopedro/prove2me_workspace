-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.inner_rotHermiteLp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterA4
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.inner_rotHermiteLp {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (a b : Fin d →₀ ℕ) :
    (inner ℂ (rotHermiteLp O a) (rotHermiteLp O b) : ℂ)
      = (inner ℂ (hermiteMvLp (d := d) a) (hermiteMvLp (d := d) b) : ℂ) := by sorry
