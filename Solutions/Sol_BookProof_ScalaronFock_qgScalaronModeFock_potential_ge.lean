-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.qgScalaronModeFock_potential_ge
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronEsa_qgScalaronMode_potential_ge
open BookProof.ScalaronFock



open Filter Topology MeasureTheory SchwartzMap


open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]
variable (a b : ℕ → ℕ → ℝ) (M alpha : ℝ) (Rc phi : ℕ → ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (halpha : 0 < alpha) (n k : ℕ) :
    -(M ^ 4 / (16 * alpha)) ≤ qgScalaronModePotential M alpha (Rc n) (phi n) k := qgScalaronMode_potential_ge M alpha (Rc n) (phi n) halpha k
