-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.bookCrossMat_eq_sym
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
open BookProof.Qg3DCrossTermEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 84) :
    bookCrossMat i j
      = ∑ a : Fin 4, ∑ b : Fin 4, (1 / 2) * (pVec a b j + pVec b a j) * eVec a b i := by

  simp only [bookCrossMat, calSVec, eTrVec, Fin.sum_univ_four]
  simp only [Fin.isValue, ↓reduceIte, Fin.reduceEq]
  ring
