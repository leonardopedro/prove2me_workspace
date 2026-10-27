-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.qgScalaronModeFock_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronFock_modeFockCore_dense
import Theorems.Thm_BookProof_ScalaronFock_qgScalaronModeFock_symmetric
import Theorems.Thm_BookProof_ScalaronFock_qgScalaronModeFock_esa
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
theorem solution :
    ∃ (T : UnboundedSelfAdjoint modeFock) (U : ℝ → (modeFock →L[ℂ] modeFock)),
      IsSelfAdjointExtension (qgScalaronModeFockHamiltonian a b M alpha Rc phi) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (modeFockCore_dense a b M alpha Rc phi)
      (qgScalaronModeFock_symmetric a b M alpha Rc phi)
      (qgScalaronModeFock_esa a b M alpha Rc phi)
