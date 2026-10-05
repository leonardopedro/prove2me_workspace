-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qg3DDensity_flat
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_momCalP_flat
import Theorems.Thm_BookProof_Qg3DDensityEsa_momCalS_flat
import Theorems.Thm_BookProof_Qg3DDensityEsa_densCross_flat
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
theorem solution (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensityHam 1 flatChi Qb
      = fqOp (kinOf calSVec calPVec 1) ((-1 : ℝ) • Qb) bookCrossMat 0 0 := by

  have hS : momCalS flatChi = calSVec := by
    funext a b j; exact momCalS_flat a b j
  have hP : momCalP flatChi = calPVec := by
    funext j; exact momCalP_flat j
  rw [qg3DDensityHam, ← densCross_flat, hS, hP]
  norm_num
