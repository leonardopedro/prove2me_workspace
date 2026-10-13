-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.ccDomain_ae
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa

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
