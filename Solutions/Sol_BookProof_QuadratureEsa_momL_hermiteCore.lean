-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.momL_hermiteCore
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_pgLp_sub_prime
import Theorems.Thm_BookProof_QuadratureEsa_momPoly_eq_cre_sub_ann
import Theorems.Thm_BookProof_QuadratureEsa_momL_coe
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_hermiteMvLp
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMvLp
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_pgLp_smul
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    momL i (hermiteCore a)
      = (Complex.I / 2) •
          (((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ) • hermiteMvLp (a + Finsupp.single i 1)
            - ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) • hermiteMvLp (a - Finsupp.single i 1)) := by

  rw [hermiteCore, momL_coe, map_smul, momPoly_eq_cre_sub_ann, smul_comm, smul_sub, pgLp_smul,
    pgLp_sub_prime, pgLp_smul, pgLp_smul, crePoly_hermiteMvLp, annPoly_hermiteMvLp]
