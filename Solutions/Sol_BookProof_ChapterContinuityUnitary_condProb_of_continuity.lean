-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.condProb_of_continuity
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_bornPMF_apply
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
namics-based unitary
(and *no* basis choice) a genuine conditional probability law
`z ↦ |Ψ_t(x, z)|²` for every input `x`: it is a probability distr :=
  ibution, and
  its mass on a set `B` of lattice sites is the Born weight `bornRecover`. -/
  theorem condProb_of_continuity (v : X → (ZMod N → ℝ)) (t : ℝ
