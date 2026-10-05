-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.ccDomain_ae
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ψ : ccDomain (Vd d)) :
    ((ψ : L2d d) : Vd d → ℂ) =ᵐ[volume]
      (((ccEquiv (Vd d)).symm ψ : ccSchwartz (Vd d)) : 𝓢(Vd d, ℂ)) := by

  have h := (((ccEquiv (Vd d)).symm ψ : ccSchwartz (Vd d)) : 𝓢(Vd d, ℂ)).coeFn_toLp 2
    (volume : Measure (Vd d))
  rwa [← ccEquiv_coe, LinearEquiv.apply_symm_apply] at h
