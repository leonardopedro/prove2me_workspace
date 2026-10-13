-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.fqPoly_add_coupling
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
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
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P Q Q' C : Fin 84 → Fin 84 → ℝ) (b b' : Fin 84 → ℝ) :
    fqPoly P Q 0 0 0 + qgCouplingPoly Q' C b b' = fqPoly P (Q + Q') C b b' := by

  have hfo : foPoly (d := 84) 0 0 = 0 := by
    simp only [foPoly, Pi.zero_apply, Complex.ofReal_zero, zero_smul, add_zero,
      Finset.sum_const_zero]
  simp only [fqPoly, qgCouplingPoly, fqQuadPoly, hfo, add_zero, Pi.add_apply, Pi.zero_apply,
    Complex.ofReal_zero, zero_smul, Complex.ofReal_add, add_smul]
  rw [← add_assoc, ← Finset.sum_add_distrib]
  refine congrArg (· + foPoly b b') (Finset.sum_congr rfl fun i _ => ?_)
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  abel
