-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.fockSmoothPotential_esa
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronEsa_smoothPotential_essentiallySelfAdjoint
open BookProof.ScalaronFock



open Filter Topology MeasureTheory SchwartzMap


open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]

set_option maxHeartbeats 1000000 in
theorem solution (W : ∀ n, E n → ℝ)
    (hW : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W n)) :
    EssentiallySelfAdjointOn (nestedCore E) (fockSmoothPotentialOp W hW) := dsOp_essentiallySelfAdjointOn _ (fun n => smoothPotential_essentiallySelfAdjoint (W n) (hW n))
