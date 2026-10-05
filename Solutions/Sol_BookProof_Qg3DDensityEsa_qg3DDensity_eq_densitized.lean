-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qg3DDensity_eq_densitized
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_qg3DDensitized_eq_density
open BookProof.Qg3DDensityEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.Qg3DCrossTermEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {y : ℝ} (hy : y ≠ 0) (chi : Fin 4 → Fin 4 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensityHam (y ^ 2) chi Qb
      = qg3DDensitizedHam y (fun a b j => momCalS chi a b j / y) (fun j => momCalP chi j / y)
          Qb := by

  rw [qg3DDensitized_eq_density hy]
  have hS : (fun a b j => y * (momCalS chi a b j / y)) = momCalS chi := by
    funext a b j; field_simp
  have hP : (fun j => y * (momCalP chi j / y)) = momCalP chi := by
    funext j; field_simp
  rw [hS, hP, qg3DDensityHam]
