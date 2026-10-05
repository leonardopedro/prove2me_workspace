-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.qgScalaronFock_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronFock_fockSmoothPotential_stone_flow
open BookProof.ScalaronFock



open Filter Topology MeasureTheory SchwartzMap


open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) :
    ∃ (T : UnboundedSelfAdjoint qgFock) (U : ℝ → (qgFock →L[ℂ] qgFock)),
      IsSelfAdjointExtension (qgScalaronFockHamiltonian M alpha) T.op ∧ IsStoneFlow T U :=
  fockSmoothPotential_stone_flow (E := qgSector) (fun n => qgManyPotential M alpha n)
      (fun n => contDiff_qgManyPotential M alpha n)
