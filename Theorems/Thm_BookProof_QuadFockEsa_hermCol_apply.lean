-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.hermCol_apply
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.QuadFockEsa

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

theorem BookProof.QuadFockEsa.hermCol_apply (e : ℕ ≃ (Fin d →₀ ℕ)) (T : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (k j : ℕ) :
    hermCol e T k j = (inner ℂ (hermiteMvLp (e j)) (pgLp (T (hpsi (e k)))) : ℂ) := by sorry
