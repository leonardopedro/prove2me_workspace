-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.det_smul_one
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_det_smul_background
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
theorem solution (c : ℝ) : (c • (1 : Matrix (Fin 4) (Fin 4) ℝ)).det = c ^ 4 := by

  rw [det_smul_background, Matrix.det_one, mul_one]
