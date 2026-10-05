-- Generated from ChapterHermiteLadderShift.lean — theorem BookProof.HermiteLadder.norm_sum_shift_sq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterHermiteLadderShift
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QgHermiteOscillator
open BookProof.HyperbolicQuadratic

noncomputable section

theorem BookProof.HermiteLadder.norm_sum_shift_sq (v : ι → E) (hv : Orthonormal ℂ v) (σ : ι → ι) (S : Finset ι)
    (hinj : ∀ a ∈ S, ∀ b ∈ S, σ a = σ b → a = b) (g : ι → ℂ) :
    ‖∑ a ∈ S, g a • v (σ a)‖ ^ 2 = ∑ a ∈ S, ‖g a‖ ^ 2 := by sorry
