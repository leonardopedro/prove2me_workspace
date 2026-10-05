-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.rotU_intertwine
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotU_pgLp
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotU_mem_core
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotPoly_foPoly
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
import Theorems.Thm_BookProof_QuadraticRotation_quadPolyMat_rotPoly
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (c : Fin d → ℝ)
    (b b' : Fin d → ℝ) (v : polyGaussCore (d := d)) :
    rotU hO ((quadOp c + foOp b b') v)
      = (quadOpMat (rotConj O c) + foOp (rotVec O b) (rotVec O b'))
          ⟨rotU hO (v : L2d d), rotU_mem_core hO v⟩ := by

  obtain ⟨p, hp⟩ := v.2
  have hv : (v : L2d d) = pgLp p := hp.symm
  have hvc : v = coreEquiv p := Subtype.ext hv
  have hUv : (⟨rotU hO (v : L2d d), rotU_mem_core hO v⟩ : polyGaussCore (d := d))
      = coreEquiv (rotPoly O p) := by
    refine Subtype.ext ?_
    change rotU hO (v : L2d d) = pgLp (rotPoly O p)
    rw [hv, rotU_pgLp]
  rw [hUv, hvc]
  simp only [LinearMap.add_apply, quadOp, quadOpMat, foOp, LinearMap.comp_apply,
    Submodule.subtype_apply, coreOp_coe, map_add, rotU_pgLp]
  rw [quadPolyMat_rotPoly hO, rotPoly_foPoly hO]
