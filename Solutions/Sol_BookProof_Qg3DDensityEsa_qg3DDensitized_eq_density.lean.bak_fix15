-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qg3DDensitized_eq_density
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_kinOf_absorption
import Theorems.Thm_BookProof_Qg3DDensityEsa_crossOf_smul
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
theorem solution {y : ℝ} (hy : y ≠ 0) (St : Fin 4 → Fin 4 → Fin 84 → ℝ)
    (Pt : Fin 84 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensitizedHam y St Pt Qb
      = fqOp (kinOf (fun a b j => y * St a b j) (fun j => y * Pt j) (1 / y ^ 2))
          ((-(y ^ 2)) • Qb) (crossOf (fun a b j => y * St a b j) (fun j => y * Pt j)) 0 0 := by

  rw [qg3DDensitizedHam, kinOf_absorption St Pt hy, crossOf_smul]
