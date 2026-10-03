-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.rotLin_apply
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.rotLin_apply (O : Matrix (Fin d) (Fin d) ℝ) (x : Vd d) (i : Fin d) :
    rotLin O x i = ∑ j, O j i * x j := by sorry
