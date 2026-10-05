-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.momCalS_flat
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_momCalP_flat
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
theorem solution (a b : Fin 4) (j : Fin 84) : momCalS flatChi a b j = calSVec a b j := by

  have hP := momCalP_flat j
  fin_cases a <;> fin_cases b <;>
    simp only [momCalS, calSVec, flatChi, hP, Fin.sum_univ_four, Fin.isValue, ↓reduceIte,
      Fin.reduceEq, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk] <;> ring
