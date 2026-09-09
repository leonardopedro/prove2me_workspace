import Mathlib
import BookProof.ChapterParity
import BookProof.ChapterYangMillsSU3

/-!
# Chapter "Quantization due to time-evolution: Yang-Mills …", §"Pure SU(3) Yang-Mills
theory" — the concrete Gell-Mann generators satisfy the defining `SU(3)` relations

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and Classical
Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"* (line ~7001), which opens
with the defining relations of the `SU(N)` generators

```
[T_a, T_b] = i f_{abc} T_c ,     tr(T_a T_b) = ½ δ_{ab}
```

`ChapterYangMillsSU3.lean` develops the structure-constant theory *abstractly*, from the
two relations as `Prop`-level hypotheses (`TraceOrthonormal`, `ClosesWithStructureConstants`).
`ChapterParity.lean` introduces the *concrete* Gell-Mann matrices `λ^a`
(`ChapterParity.gellMann`) and proves their complex-conjugation sign law.  This file closes
the gap by verifying that the concrete Gell-Mann matrices really are a system of `SU(3)`
generators: they are **Hermitian**, **traceless**, and **trace-orthonormal**, and the
rescaled generators `T_a = ½ λ^a` satisfy the book's normalization `tr(T_a T_b) = ½ δ_{ab}`
— i.e. they discharge the abstract `TraceOrthonormal` hypothesis of `ChapterYangMillsSU3`.

## Contents

* `gellMann_isHermitian` — `(λ^a)ᴴ = λ^a` (each generator is self-adjoint);
* `gellMann_trace_zero` — `tr(λ^a) = 0` (each generator is traceless, so `T_a ∈ su(3)`);
* `gellMann_trace_orthonormal` — `tr(λ^a λ^b) = 2 δ_{ab}` (the physics normalization of the
  Gell-Mann basis, including the `λ⁸` case where the `1/√3` normalization is essential);
* `su3gen` — the generators `T_a = ½ λ^a`, with `su3gen_isHermitian`, `su3gen_trace_zero`;
* `su3gen_traceOrthonormal` — **bridge**: `T_a = ½ λ^a` satisfies
  `YangMillsSU3.TraceOrthonormal`, i.e. `tr(T_a T_b) = ½ δ_{ab}`, so the concrete Gell-Mann
  system meets the abstract hypothesis used throughout `ChapterYangMillsSU3`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterGellMann

open BookProof.ChapterParity

/-- **Each Gell-Mann generator is Hermitian:** `(λ^a)ᴴ = λ^a`. -/
theorem gellMann_isHermitian (a : Fin 8) : (gellMann a).IsHermitian := by
  fin_cases a <;>
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [gellMann, Matrix.conjTranspose_apply, Complex.conj_I,
        Matrix.smul_apply, Complex.conj_ofReal]

/-- **Each Gell-Mann generator is traceless:** `tr(λ^a) = 0`.  Hence `T_a = ½ λ^a` lies in
`su(3)` (Hermitian and traceless). -/
theorem gellMann_trace_zero (a : Fin 8) : (gellMann a).trace = 0 := by
  fin_cases a <;>
    simp [gellMann, Matrix.trace, Matrix.diag, Fin.sum_univ_three, Matrix.smul_apply] ;
    ring

/-- **Trace-orthonormality of the Gell-Mann basis:** `tr(λ^a λ^b) = 2 δ_{ab}`.  The `a = b = 8`
case relies on the `1/√3` normalization: `tr((λ⁸)²) = (1/√3)²·(1+1+4) = 2`. -/
theorem gellMann_trace_orthonormal (a b : Fin 8) :
    (gellMann a * gellMann b).trace = (if a = b then (2 : ℂ) else 0) := by
  have h3 : (Real.sqrt 3) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  fin_cases a <;> fin_cases b <;>
    simp [gellMann, Matrix.trace, Matrix.diag, Matrix.mul_apply, Fin.sum_univ_three,
      Complex.ext_iff] <;>
    norm_num [Complex.ext_iff] ;
    nlinarith [h3, Real.sqrt_nonneg 3]

/-- The `SU(3)` generators in the physics normalization, `T_a = ½ λ^a`. -/
noncomputable def su3gen (a : Fin 8) : Matrix (Fin 3) (Fin 3) ℂ :=
  (1 / 2 : ℂ) • gellMann a

/-- `T_a = ½ λ^a` is Hermitian. -/
theorem su3gen_isHermitian (a : Fin 8) : (su3gen a).IsHermitian := by
  rw [Matrix.IsHermitian, su3gen, Matrix.conjTranspose_smul, (gellMann_isHermitian a)]
  norm_num

/-- `T_a = ½ λ^a` is traceless. -/
theorem su3gen_trace_zero (a : Fin 8) : (su3gen a).trace = 0 := by
  simp [su3gen, Matrix.trace_smul, gellMann_trace_zero a]

/-- **Bridge to `ChapterYangMillsSU3`.**  The concrete generators `T_a = ½ λ^a` satisfy the
book's normalization `tr(T_a T_b) = ½ δ_{ab}`, i.e. they discharge the abstract
`YangMillsSU3.TraceOrthonormal` hypothesis used throughout `ChapterYangMillsSU3`. -/
theorem su3gen_traceOrthonormal : YangMillsSU3.TraceOrthonormal su3gen := by
  intro a b
  have h : su3gen a * su3gen b = (1 / 4 : ℂ) • (gellMann a * gellMann b) := by
    simp only [su3gen, smul_mul_smul_comm]; norm_num
  rw [h, Matrix.trace_smul, gellMann_trace_orthonormal]
  by_cases hab : a = b <;> simp only [hab, if_true, if_false, smul_eq_mul] <;> norm_num

end BookProof.ChapterGellMann
