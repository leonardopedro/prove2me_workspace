-- Generated from ChapterE.lean — solution of BookProof.ChapterE.hadamard_uniformizes
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE



open scoped Matrix BigOperators
open Filter
open scoped Topology

set_option maxHeartbeats 1000000 in

theorem solution :
    let H : Matrix (Fin 2) (Fin 2) ℂ :=
      (1 / Real.sqrt 2 : ℂ) • !![1, 1; 1, -1]
    Hᴴ * H = 1 ∧ ∀ i j, ‖H i j‖ ^ 2 = 1 / 2 := by
  norm_num [ Fin.forall_fin_two, ← Matrix.ext_iff ];
  norm_num [ Matrix.mul_apply, Complex.ext_iff ];
  ring_nf; norm_num;

/-
**E.3 (general `n`).** For every `n ≥ 1` there is a unitary `n × n` matrix
that maps every computational basis state to the uniform Born distribution
`|·|² = 1/n` (the DFT / "black hole" uniformizer).
-/
