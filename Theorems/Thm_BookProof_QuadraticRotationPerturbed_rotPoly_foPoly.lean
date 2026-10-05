-- Generated from ChapterQuadraticRotationPerturbed.lean — theorem BookProof.QuadraticRotationPerturbed.rotPoly_foPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QuadraticRotationPerturbed

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.QuadraticRotationPerturbed.rotPoly_foPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (b b' : Fin d → ℝ)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (foPoly b b' p) = foPoly (rotVec O b) (rotVec O b') (rotPoly O p) := by sorry
