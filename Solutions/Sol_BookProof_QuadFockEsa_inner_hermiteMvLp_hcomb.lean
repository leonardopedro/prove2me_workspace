-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.inner_hermiteMvLp_hcomb
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_QuadFockEsa_pgLp_hcomb
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteBand
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f : (Fin d →₀ ℕ) →₀ ℂ) (β : Fin d →₀ ℕ) :
    (inner ℂ (hermiteMvLp β) (pgLp (hcomb f)) : ℂ) = f β := by

  classical
  rw [pgLp_hcomb, inner_sum]
  have hterm : ∀ γ ∈ f.support,
      (inner ℂ (hermiteMvLp β) (f γ • hermiteMvLp γ) : ℂ) = if β = γ then f γ else 0 := by
    intro γ _
    rw [inner_smul_right, inner_hermiteMvLp]
    split <;> simp_all
  rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq f.support β f]
  split
  · rfl
  · exact (Finsupp.notMem_support_iff.mp (by assumption)).symm
