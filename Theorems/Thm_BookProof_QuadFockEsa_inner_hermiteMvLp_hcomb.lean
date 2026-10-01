-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.inner_hermiteMvLp_hcomb
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

theorem BookProof.QuadFockEsa.inner_hermiteMvLp_hcomb (f : (Fin d →₀ ℕ) →₀ ℂ) (β : Fin d →₀ ℕ) :
    (inner ℂ (hermiteMvLp β) (pgLp (hcomb f)) : ℂ) = f β := by sorry
