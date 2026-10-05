-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.fockSmoothPotential_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronFock_nestedCore_dense
import Theorems.Thm_BookProof_ScalaronFock_fockSmoothPotential_symmetric
import Theorems.Thm_BookProof_ScalaronFock_fockSmoothPotential_esa
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
    ∃ (T : UnboundedSelfAdjoint (nestedFock E)) (U : ℝ → (nestedFock E →L[ℂ] nestedFock E)),
      IsSelfAdjointExtension (fockSmoothPotentialOp W hW) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (fockSmoothPotentialOp W hW) (nestedCore_dense (E := E))
      (fockSmoothPotential_symmetric W hW) (fockSmoothPotential_esa W hW)
