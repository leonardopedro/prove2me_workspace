-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.crossOf_smul
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
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
theorem solution (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) (y : ℝ) :
    crossOf (fun a b j => y * S a b j) (fun j => y * P j) = y • crossOf S P := by

  funext i j
  simp only [crossOf, Pi.smul_apply, smul_eq_mul, mul_add, Finset.mul_sum]
  congr 1
  · exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  · ring
