-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.oscL_hermiteMvLp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.HermiteRelative



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

theorem BookProof.HermiteRelative.oscL_hermiteMvLp (i : Fin d) (a : Fin d →₀ ℕ)
    (h : hermiteMvLp a ∈ polyGaussCore (d := d)) :
    oscL i ⟨hermiteMvLp a, h⟩ = (((a i : ℝ) + 1/2 : ℝ) : ℂ) • hermiteMvLp a := by sorry
