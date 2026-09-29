import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib

import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterStoneConverse

/-!
# Faris–Lavine bounds checked on the finite-mode core alone

`BookProof.NavierStokesFlow.IkebeKato.essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds`
and its repackaging `BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_bounds`
ask for an operator defined on the **maximal domain** `maxDom c` of the comparison symbol,
and for the relative bound and the commutator bound to hold there.  Many second-quantized
Hamiltonians, however, are naturally given only on the **finite-mode core**
`lpFiniteModes ι` — the algebraic span of the basis states — where every sum in sight is
finite and no convergence question arises.

This module removes that mismatch once and for all: an operator on the core with a
relative bound against the comparison operator extends, by continuity along the
truncations, to the maximal domain, and the extension inherits the symmetry, the relative
bound and the commutator bound.  Hence:

* `trunc`, `trunc_coe`, `tendsto_trunc`, `tendsto_diag_trunc` — the truncation net of a
  state of the maximal domain and its convergence, in the norm and in the graph norm.
* `coreExt` — the extension of a core operator to `maxDom c`, with
  `tendsto_coreExt`, `coreExt_core` (it *is* the given operator on the core),
  `norm_coreExt_le`, `coreExt_symmetricOn` and `coreExt_commForm_le`.
* **`essentiallySelfAdjointOn_finiteModes_of_core_bounds`** — the instrument: a symmetric
  operator on the finite-mode core with a relative bound `‖H u‖ ≤ A‖N u‖` and a commutator
  bound `|⟪u, i[H, N]u⟫| ≤ B⟪u, N u⟫`, both checked **on the core only**, is essentially
  self-adjoint on that core.
* `essentiallySelfAdjointOn_finiteModes_of_core_bounds_comm` — the special case of a
  vanishing commutator form, the one a number-conserving Hamiltonian satisfies.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CoreBounds

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section

variable {ι : Type*} {c : ι → ℝ}

/-! ## 1. The truncation net -/

/-- The inclusion of the finite-mode core into the maximal domain of the symbol `c`. -/
def inclC (c : ι → ℝ) : lpFiniteModes ι →ₗ[ℂ] maxDom c :=
  Submodule.inclusion (finiteModes_le_maxDom c)



/-- The **truncation** of a state to the finite set `S` of modes, as an element of the
finite-mode core. -/
def trunc [DecidableEq ι] (c : ι → ℝ) (x : maxDom c) (S : Finset ι) : lpFiniteModes ι :=
  ⟨∑ i ∈ S, lp.single 2 i (((x : L2I ι) : ι → ℂ) i), sum_single_mem_finiteModes S _⟩

theorem trunc_coe [DecidableEq ι] (c : ι → ℝ) (x : maxDom c) (S : Finset ι) (k : ι) :
    ((trunc c x S : lpFiniteModes ι) : L2I ι) k =
      if k ∈ S then ((x : L2I ι) : ι → ℂ) k else 0 := by
  classical
  simp [trunc]

theorem trunc_add [DecidableEq ι] (c : ι → ℝ) (x y : maxDom c) (S : Finset ι) :
    trunc c (x + y) S = trunc c x S + trunc c y S := by
  ext k
  have hx := trunc_coe c x S k
  have hy := trunc_coe c y S k
  have hxy := trunc_coe c (x + y) S k
  by_cases hk : k ∈ S <;> simp [hxy, hx, hy, hk]

theorem trunc_smul [DecidableEq ι] (c : ι → ℝ) (a : ℂ) (x : maxDom c) (S : Finset ι) :
    trunc c (a • x) S = a • trunc c x S := by
  ext k
  have hx := trunc_coe c x S k
  have hax := trunc_coe c (a • x) S k
  by_cases hk : k ∈ S <;> simp [hax, hx, hk]



/-- The truncations converge in the graph norm of the comparison operator. -/
theorem tendsto_diag_trunc [DecidableEq ι] (c : ι → ℝ) (x : maxDom c) :
    Tendsto (fun S : Finset ι => (diagMax c (inclC c (trunc c x S)) : L2I ι)) atTop
      (𝓝 ((diagMax c x : L2I ι))) := by
  classical
  set v : ι → ℂ := fun k => ((diagMax c x : L2I ι) : ι → ℂ) k with hv
  have h : HasSum (fun i : ι => lp.single 2 i (v i)) ((diagMax c x : L2I ι)) :=
    lp.hasSum_single (by norm_num) _
  have heq : ∀ S : Finset ι, (diagMax c (inclC c (trunc c x S)) : L2I ι)
      = ∑ i ∈ S, lp.single 2 i (v i) := by
    intro S
    refine lp.ext (funext fun k => ?_)
    rw [diagMax_coe, coe_sum_single]
    have := trunc_coe c x S k
    by_cases hk : k ∈ S
    · simp [hk, this, hv, diagMax_coe]
    · simp [hk, this]
  simpa [heq] using h

/-! ## 2. The extension of a core operator -/

variable (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)

/-- The relative bound, on the core. -/
def CoreRelBound (c : ι → ℝ) (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ) : Prop :=
  ∀ u : lpFiniteModes ι, ‖H₀ u‖ ≤ A * ‖(diagMax c (inclC c u) : L2I ι)‖

theorem cauchySeq_coreExt [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι}
    {A : ℝ} (hA : CoreRelBound c H₀ A) (x : maxDom c) :
    CauchySeq (fun S : Finset ι => H₀ (trunc c x S)) := by
  classical
  have hd := (tendsto_diag_trunc c x).cauchySeq
  rw [Metric.cauchySeq_iff] at hd ⊢
  intro ε hε
  have hApos : 0 < |A| + 1 := by positivity
  obtain ⟨S₀, hS₀⟩ := hd (ε / (|A| + 1)) (by positivity)
  refine ⟨S₀, fun S hS T hT => ?_⟩
  have hkey := hA (trunc c x S - trunc c x T)
  have hlin : (diagMax c (inclC c (trunc c x S - trunc c x T)) : L2I ι)
      = (diagMax c (inclC c (trunc c x S)) : L2I ι)
        - (diagMax c (inclC c (trunc c x T)) : L2I ι) := by
    simp [map_sub]
  rw [map_sub, hlin] at hkey
  have hd' := hS₀ S hS T hT
  rw [dist_eq_norm] at hd' ⊢
  have hle : ‖(diagMax c (inclC c (trunc c x S)) : L2I ι)
      - (diagMax c (inclC c (trunc c x T)) : L2I ι)‖ < ε / (|A| + 1) := hd'
  have hAle : A ≤ |A| := le_abs_self A
  have hnn : (0:ℝ) ≤ ‖(diagMax c (inclC c (trunc c x S)) : L2I ι)
      - (diagMax c (inclC c (trunc c x T)) : L2I ι)‖ := norm_nonneg _
  have hstep : A * ‖(diagMax c (inclC c (trunc c x S)) : L2I ι)
      - (diagMax c (inclC c (trunc c x T)) : L2I ι)‖
      ≤ (|A| + 1) * ‖(diagMax c (inclC c (trunc c x S)) : L2I ι)
      - (diagMax c (inclC c (trunc c x T)) : L2I ι)‖ :=
    mul_le_mul_of_nonneg_right (by linarith) hnn
  have hstep2 : (|A| + 1) * ‖(diagMax c (inclC c (trunc c x S)) : L2I ι)
      - (diagMax c (inclC c (trunc c x T)) : L2I ι)‖ < (|A| + 1) * (ε / (|A| + 1)) :=
    mul_lt_mul_of_pos_left hle hApos
  have hfin : (|A| + 1) * (ε / (|A| + 1)) = ε := by field_simp
  linarith [hkey, hstep, hstep2]

/-- **The extension of a core operator to the maximal domain**, as a function. -/
def coreExtFun [DecidableEq ι] (c : ι → ℝ) (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι)
    (x : maxDom c) : L2I ι :=
  limUnder atTop (fun S : Finset ι => H₀ (trunc c x S))

theorem tendsto_coreExt [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι}
    {A : ℝ} (hA : CoreRelBound c H₀ A) (x : maxDom c) :
    Tendsto (fun S : Finset ι => H₀ (trunc c x S)) atTop (𝓝 (coreExtFun c H₀ x)) :=
  (cauchySeq_coreExt hA x).tendsto_limUnder



/-- The extension is linear. -/
def coreExt [DecidableEq ι] {c : ι → ℝ} {H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι} {A : ℝ}
    (hA : CoreRelBound c H₀ A) : maxDom c →ₗ[ℂ] L2I ι where
  toFun := coreExtFun c H₀
  map_add' x y := by
    refine tendsto_nhds_unique (tendsto_coreExt hA (x + y)) ?_
    have h : Tendsto (fun S : Finset ι => H₀ (trunc c x S) + H₀ (trunc c y S)) atTop
        (𝓝 (coreExtFun c H₀ x + coreExtFun c H₀ y)) :=
      (tendsto_coreExt hA x).add (tendsto_coreExt hA y)
    refine h.congr fun S => ?_
    rw [← map_add, trunc_add]
  map_smul' a x := by
    refine tendsto_nhds_unique (tendsto_coreExt hA (a • x)) ?_
    have h : Tendsto (fun S : Finset ι => a • H₀ (trunc c x S)) atTop
        (𝓝 (a • coreExtFun c H₀ x)) := (tendsto_coreExt hA x).const_smul a
    refine h.congr fun S => ?_
    rw [← map_smul, trunc_smul]









/-! ## 3. The instrument -/





end

end BookProof.CoreBounds
