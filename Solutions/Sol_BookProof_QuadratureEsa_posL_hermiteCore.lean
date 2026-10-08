-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.posL_hermiteCore
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_pgLp_add_prime
import Theorems.Thm_BookProof_QuadratureEsa_mulXPoly_eq_cre_add_ann
import Theorems.Thm_BookProof_QuadratureEsa_posL_coe
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_hermiteMvLp
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMvLp
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_pgLp_smul
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    posL i (hermiteCore a)
      = ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ) • hermiteMvLp (a + Finsupp.single i 1)
        + ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) • hermiteMvLp (a - Finsupp.single i 1) := by

  rw [hermiteCore, posL_coe, map_smul, mulXPoly_eq_cre_add_ann, smul_add, pgLp_add_prime, pgLp_smul,
    pgLp_smul, crePoly_hermiteMvLp, annPoly_hermiteMvLp]
