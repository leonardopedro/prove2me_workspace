-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.hermCol_eq_coef
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

theorem BookProof.QuadFockEsa.hermCol_eq_coef (e : ℕ ≃ (Fin d →₀ ℕ)) {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    {f : (Fin d →₀ ℕ) →₀ ℂ} {k : ℕ} (hf : T (hpsi (e k)) = hcomb f) (j : ℕ) :
    hermCol e T k j = f (e j) := by sorry
