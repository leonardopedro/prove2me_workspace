import Mathlib
import BookProof.ChapterQgOuterFockFlow
import BookProof.ChapterHashimotoComplexShifts

/-!
# Strong resolvent convergence of the mode-truncated quantum-gravity Hamiltonians

`BookProof.ChapterQgOuterFockFlow` proves that the outer-Fock quantum-gravity Hamiltonian
generates a unique unitary flow, and transfers *assumed* strong resolvent convergence of a
family of approximations into convergence of the flows.  This module removes the assumption
for the canonical discretization: the **mode truncation**, in which the vielbein
self-interaction `A` and the scalaron–vielbein coupling `B` are switched off outside a
finite window of modes, while the fibre operator — the scalaron kinetic term, the harmonic
term and the *full exponential* Starobinsky wall — is kept exactly.

## What is proved

* `esa_core_of_ext` — essential self-adjointness on the whole comparison domain descends to
  the graph core: the Faris–Lavine conclusion, which is proved on `𝒟(N)`, also holds on the
  finite-particle core, because the core approximates `𝒟(N)` in the graph norm and the
  Hamiltonian is relatively bounded.
* `strongResolventConvergence_of_dense`, `tendsto_resCLM_shift`,
  **`strongResolventConvergence_of_core`** — the general criterion (Reed–Simon VIII.25(a)):
  self-adjoint realizations of operators that converge pointwise on a common essentially
  self-adjoint core converge in the strong resolvent sense.
* `QgModeData.truncate` — the mode truncation of the quantum-gravity mode data: the same
  vielbein energies and bands, the interaction matrices restricted to a window `Λ`, and the
  *same* Faris–Lavine constant `K` (switching entries off cannot increase a Schur sum), so
  the truncated Hamiltonian is essentially self-adjoint by the same theorem.
* `secHam_truncate_eventually_eq` — on each core vector the truncated Hamiltonian eventually
  agrees with the exact one along an exhausting family of windows.
* **`qgOuterFock_truncation_flow_convergence`** — hence the truncated flows converge to the
  exact quantum-gravity flow, uniformly on compact time intervals; no hypothesis of
  resolvent convergence is assumed.  `starobinsky_qgContinuum_momentumCutoff_flow_convergence`
  is the physical instance: the exact Fourier modes of the vielbein with a momentum cutoff
  `|k| ≤ n`, the full exponential Einstein-frame wall and arbitrary coupling constant.

The mode cutoff analysed here is the *space* half of a concrete scheme.  The *time* half —
the Crank–Nicolson (Cayley) step, its unitarity, its consistency and the convergence of the
fully discrete evolution — is `BookProof.ChapterQgTimeStepping`; and the general theorems
below are stated for an arbitrary mode index type, so they apply verbatim over a general
spatial manifold (`BookProof.ChapterQgManifoldModeInstance`) and not only over the periodic
box used in the instance of §5.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgTruncationResolvent

open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. Essential self-adjointness descends to the graph core -/

/-- **Essential self-adjointness on the comparison domain descends to the graph core.**
A vector annihilating the deficiency equation on the core annihilates it on all of `𝒟(N)`,
because every domain vector is a graph limit of core vectors and `ext` is continuous along
such limits. -/
theorem esa_core_of_ext (d : CoreData F) (hesa : EssentiallySelfAdjointOn d.C.dom d.ext) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by
  have key : ∀ z : ℂ, DeficiencyTrivialAt d.C.dom d.ext z → DeficiencyTrivialAt d.C₀ d.H₀ z := by
    intro z hz w hw
    refine hz w fun x => ?_
    have h1 : Tendsto (fun k => (inner ℂ (d.ext (d.gcSeq x k)) w : ℂ)) atTop
        (𝓝 (inner ℂ (d.ext x) w : ℂ)) := (d.gcSeq_ext_tendsto x).inner tendsto_const_nhds
    have h2 : Tendsto (fun k => z * (inner ℂ ((d.gcSeq x k : d.C.dom) : F) w : ℂ)) atTop
        (𝓝 (z * (inner ℂ (x : F) w : ℂ))) :=
      ((d.gcSeq_tendsto x).inner tendsto_const_nhds).const_mul z
    have heq : ∀ k, (inner ℂ (d.ext (d.gcSeq x k)) w : ℂ)
        = z * (inner ℂ ((d.gcSeq x k : d.C.dom) : F) w : ℂ) := by
      intro k
      rw [d.ext_gcSeq x k]
      exact hw ⟨_, d.gcSeq_mem x k⟩
    exact tendsto_nhds_unique (by simpa only [heq] using h1) h2
  exact ⟨key _ hesa.1, key _ hesa.2⟩

/-! ## 2. A criterion for strong resolvent convergence -/

/-- Strong resolvent convergence needs only be checked on a dense set: the resolvents at `i`
are contractions. -/
theorem strongResolventConvergence_of_dense {T : UnboundedSelfAdjoint F}
    {S : ℕ → UnboundedSelfAdjoint F} {G : Set F} (hG : Dense G)
    (h : ∀ y ∈ G, Tendsto (fun n => (S n).resCLM 1 y) atTop (𝓝 (T.resCLM 1 y))) :
    StrongResolventConvergence T S := by
  intro y
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨y', hy'G, hy'⟩ := Metric.mem_closure_iff.mp (hG y) (ε / 3) (by linarith)
  have hbound : ∀ (R : UnboundedSelfAdjoint F) (z : F), ‖R.resCLM 1 z‖ ≤ ‖z‖ := by
    intro R z
    have := R.norm_resCLM_apply_le 1 z
    simpa using this
  have hyy : ‖y - y'‖ < ε / 3 := by rwa [← dist_eq_norm]
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp (h y' hy'G) (ε / 3) (by linarith)
  refine ⟨N, fun n hn => ?_⟩
  have hsplit : (S n).resCLM 1 y - T.resCLM 1 y
      = (S n).resCLM 1 (y - y') + ((S n).resCLM 1 y' - T.resCLM 1 y')
        - T.resCLM 1 (y - y') := by
    rw [map_sub, map_sub]; abel
  have h1 : ‖(S n).resCLM 1 (y - y')‖ ≤ ‖y - y'‖ := hbound _ _
  have h2 : ‖T.resCLM 1 (y - y')‖ ≤ ‖y - y'‖ := hbound _ _
  have h3 : ‖(S n).resCLM 1 y' - T.resCLM 1 y'‖ < ε / 3 := by
    have := hN n hn
    rwa [dist_eq_norm] at this
  have : ‖(S n).resCLM 1 y - T.resCLM 1 y‖ < ε := by
    rw [hsplit]
    calc ‖(S n).resCLM 1 (y - y') + ((S n).resCLM 1 y' - T.resCLM 1 y') - T.resCLM 1 (y - y')‖
        ≤ ‖(S n).resCLM 1 (y - y') + ((S n).resCLM 1 y' - T.resCLM 1 y')‖
            + ‖T.resCLM 1 (y - y')‖ := norm_sub_le _ _
      _ ≤ ‖(S n).resCLM 1 (y - y')‖ + ‖(S n).resCLM 1 y' - T.resCLM 1 y'‖
            + ‖T.resCLM 1 (y - y')‖ := by
            have := norm_add_le ((S n).resCLM 1 (y - y'))
              ((S n).resCLM 1 y' - T.resCLM 1 y')
            linarith
      _ < ε := by linarith
  rwa [dist_eq_norm]

/-- **Pointwise convergence of the operators gives pointwise convergence of the resolvents**
on the image of the common domain vector under `T - i`. -/
theorem tendsto_resCLM_shift (T : UnboundedSelfAdjoint F) (S : ℕ → UnboundedSelfAdjoint F)
    {x : F} (hT : x ∈ T.domain) (hS : ∀ n, x ∈ (S n).domain)
    (hconv : Tendsto (fun n => (S n).op ⟨x, hS n⟩) atTop (𝓝 (T.op ⟨x, hT⟩))) :
    Tendsto (fun n => (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩)) atTop
      (𝓝 (T.resCLM 1 (T.shift 1 ⟨x, hT⟩))) := by
  have hfix : T.resCLM 1 (T.shift 1 ⟨x, hT⟩) = x := by
    have := T.res_shift (l := 1) one_ne_zero ⟨x, hT⟩
    simpa using congrArg (fun u : T.domain => (u : F)) this
  rw [hfix, tendsto_iff_norm_sub_tendsto_zero]
  have hdiff : ∀ n, (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - x
      = (S n).resCLM 1 (T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩) := by
    intro n
    have hres : (S n).resCLM 1 ((S n).shift 1 ⟨x, hS n⟩) = x := by
      have := (S n).res_shift (l := 1) one_ne_zero ⟨x, hS n⟩
      simpa using congrArg (fun u : (S n).domain => (u : F)) this
    have hsub : T.shift 1 ⟨x, hT⟩ - (S n).shift 1 ⟨x, hS n⟩
        = T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩ := by
      rw [UnboundedSelfAdjoint.shift_apply, UnboundedSelfAdjoint.shift_apply]
      simp
    calc (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - x
        = (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - (S n).resCLM 1 ((S n).shift 1 ⟨x, hS n⟩) := by
          rw [hres]
      _ = (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩ - (S n).shift 1 ⟨x, hS n⟩) := (map_sub _ _ _).symm
      _ = (S n).resCLM 1 (T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩) := by rw [hsub]
  have hnorm : ∀ n, ‖(S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - x‖
      ≤ ‖T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩‖ := by
    intro n
    rw [hdiff n]
    have := (S n).norm_resCLM_apply_le 1 (T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩)
    simpa using this
  have h0 : Tendsto (fun n => ‖T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩‖) atTop (𝓝 0) := by
    have := (tendsto_iff_norm_sub_tendsto_zero.mp hconv)
    simpa only [norm_sub_rev] using this
  exact squeeze_zero (fun n => norm_nonneg _) hnorm h0

/-- **The core criterion for strong resolvent convergence.**  If `Hc` is essentially
self-adjoint on `D`, if `T` and `S n` are self-adjoint realizations of `Hc` and of operators
`Hn n` on the same domain `D`, and if `Hn n x → Hc x` for every `x ∈ D`, then the resolvents
converge strongly. -/
theorem strongResolventConvergence_of_core {D : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {Hn : ℕ → (D →ₗ[ℂ] F)} {T : UnboundedSelfAdjoint F} {S : ℕ → UnboundedSelfAdjoint F}
    (hesa : EssentiallySelfAdjointOn D Hc) (hT : IsSelfAdjointExtension Hc T.op)
    (hS : ∀ n, IsSelfAdjointExtension (Hn n) (S n).op)
    (hconv : ∀ x : D, Tendsto (fun n => Hn n x) atTop (𝓝 (Hc x))) :
    StrongResolventConvergence T S := by
  have hmemT : ∀ x : D, (x : F) ∈ T.domain := fun x => (hT.1 x).choose
  have hopT : ∀ x : D, T.op ⟨(x : F), hmemT x⟩ = Hc x := fun x => (hT.1 x).choose_spec
  have hmemS : ∀ (n : ℕ) (x : D), (x : F) ∈ (S n).domain := fun n x => ((hS n).1 x).choose
  have hopS : ∀ (n : ℕ) (x : D), (S n).op ⟨(x : F), hmemS n x⟩ = Hn n x :=
    fun n x => ((hS n).1 x).choose_spec
  set Phi : D →ₗ[ℂ] F :=
    (T.shift 1).comp (Submodule.inclusion (fun x hx => hmemT ⟨x, hx⟩)) with hPhi
  have hPhi_apply : ∀ x : D, Phi x = T.shift 1 ⟨(x : F), hmemT x⟩ := fun _ => rfl
  have hdense : Dense ((LinearMap.range Phi : Submodule ℂ F) : Set F) := by
    rw [Submodule.dense_iff_topologicalClosure_eq_top, Submodule.topologicalClosure_eq_top_iff,
      Submodule.eq_bot_iff]
    intro w hw
    have hzero : ∀ v : D, (inner ℂ (Phi v) w : ℂ) = 0 := fun v =>
      (Submodule.mem_orthogonal _ _).mp hw (Phi v) ⟨v, rfl⟩
    refine hesa.2 w fun v => ?_
    have h := hzero v
    rw [hPhi_apply v, UnboundedSelfAdjoint.shift_apply, hopT v] at h
    have h2 : (inner ℂ (Hc v) w : ℂ) - (inner ℂ (((1 : ℝ) * Complex.I : ℂ) • (v : F)) w : ℂ)
        = 0 := by rw [← inner_sub_left]; exact h
    rw [inner_smul_left] at h2
    simp only [Complex.ofReal_one, one_mul, Complex.conj_I] at h2 ⊢
    linear_combination h2
  refine strongResolventConvergence_of_dense hdense ?_
  rintro y ⟨v, rfl⟩
  rw [hPhi_apply v]
  refine tendsto_resCLM_shift T S (hmemT v) (fun n => hmemS n v) ?_
  rw [hopT v]
  simpa only [hopS] using hconv v

/-! ## 3. The mode truncation of the quantum-gravity Hamiltonian -/

variable {ι : Type*}

open Classical in
/-- **The mode truncation of the quantum-gravity mode data.**  The vielbein energies, the
bands and hence the fibre operator — the scalaron kinetic term, the harmonic term and the
full exponential Starobinsky wall — are kept exactly; the vielbein self-interaction and the
scalaron–vielbein coupling are switched off outside the window `Λ`.  Switching entries off
cannot increase any of the five Schur sums, so the Faris–Lavine constant `K` is unchanged
and the truncated Hamiltonian is essentially self-adjoint by the same theorem. -/
def truncModes (Q : QgModeData ι) (Λ : Set ι) : QgModeData ι where
  sig := Q.sig
  one_le_sig := Q.one_le_sig
  A := fun a b => if a ∈ Λ ∧ b ∈ Λ then Q.A a b else 0
  B := fun a b => if a ∈ Λ ∧ b ∈ Λ then Q.B a b else 0
  nbr := Q.nbr
  mem_nbr_comm := Q.mem_nbr_comm
  A_off := by
    intro a b h
    by_cases hc : a ∈ Λ ∧ b ∈ Λ <;> simp [hc, Q.A_off a b h]
  B_off := by
    intro a b h
    by_cases hc : a ∈ Λ ∧ b ∈ Λ <;> simp [hc, Q.B_off a b h]
  A_herm := by
    intro a b
    by_cases ha : a ∈ Λ <;> by_cases hb : b ∈ Λ <;> simp [ha, hb, Q.A_herm a b]
  B_herm := by
    intro a b
    by_cases ha : a ∈ Λ <;> by_cases hb : b ∈ Λ <;> simp [ha, hb, Q.B_herm a b]
  K := Q.K
  K_nonneg := Q.K_nonneg
  A_rel_row := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.A_rel_row a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero, zero_div]
      exact div_nonneg (norm_nonneg _) (Q.sig_nonneg b)
  A_rel_col := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.A_rel_col a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero]
      exact norm_nonneg _
  A_comm := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.A_comm a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero, mul_zero]
      positivity
  B_rel := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.B_rel a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero]
      exact norm_nonneg _
  B_comm := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.B_comm a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero, mul_zero]
      positivity

@[simp] theorem truncModes_sig (Q : QgModeData ι) (Λ : Set ι) :
    (truncModes Q Λ).sig = Q.sig := rfl

@[simp] theorem truncModes_nbr (Q : QgModeData ι) (Λ : Set ι) :
    (truncModes Q Λ).nbr = Q.nbr := rfl

/-- The finite-particle core is dense in the outer Fock space. -/
theorem secCore_dense :
    Dense ((secCore (ι := ι) : Submodule ℂ (Sec ι)) : Set (Sec ι)) :=
  dsCore_dense fun _ => ccDomain_dense

variable (W : WallPot) (Q : QgModeData ι)

/-- **Essential self-adjointness of the quantum-gravity Hamiltonian on the finite-particle
core itself** (and not only on the domain of the comparison operator). -/
theorem secHam_esa_core : EssentiallySelfAdjointOn (secCore (ι := ι)) (secHam W Q) :=
  esa_core_of_ext (secData W Q) (secHam_essentiallySelfAdjointOn W Q)

/-- **The truncated Hamiltonian agrees with the exact one on a core vector whose band lies
inside the window.** -/
theorem secHam_truncate_eq_of_band (Λ : Set ι) {x : secCore (ι := ι)} {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0)
    (hPΛ : ∀ a ∈ P, a ∈ Λ) :
    secHam W (truncModes Q Λ) x = secHam W Q x := by
  classical
  refine lp.ext (funext fun a => ?_)
  rw [secHam_apply, secHam_apply]
  simp only [truncModes_sig, truncModes_nbr]
  have hmem : ∀ b ∈ Q.nbr a, (x : Sec ι) b ≠ 0 → (a ∈ Λ ∧ b ∈ Λ) := by
    intro b hb hne
    have hbP : b ∈ P := by by_contra hc; exact hne (hP1 b hc)
    have haP : a ∈ P := by
      by_contra hc
      exact hne (hP2 a hc b hb)
    exact ⟨hPΛ a haP, hPΛ b hbP⟩
  have hA : ∀ b ∈ Q.nbr a,
      (truncModes Q Λ).A a b • ((fibOf x b : ccDomain ℝ) : L2R)
        = Q.A a b • ((fibOf x b : ccDomain ℝ) : L2R) := by
    intro b hb
    by_cases hne : (x : Sec ι) b = 0
    · rw [fibOf_eq_zero hne]
      simp
    · have h := hmem b hb hne
      simp only [truncModes]
      rw [if_pos h]
  have hB : ∀ b ∈ Q.nbr a,
      (truncModes Q Λ).B a b • xCc (fibOf x b) = Q.B a b • xCc (fibOf x b) := by
    intro b hb
    by_cases hne : (x : Sec ι) b = 0
    · rw [fibOf_eq_zero hne]
      simp
    · have h := hmem b hb hne
      simp only [truncModes]
      rw [if_pos h]
  rw [Finset.sum_congr rfl hA, Finset.sum_congr rfl hB]

/-- **The truncated Hamiltonians converge pointwise on the core** along an exhausting family
of windows. -/
theorem secHam_truncate_eventually_eq (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) (x : secCore (ι := ι)) :
    ∀ᶠ n in atTop, secHam W (truncModes Q (Λ n)) x = secHam W Q x := by
  obtain ⟨P, hP1, hP2⟩ := exists_band Q x
  filter_upwards [hexh P] with n hn
  exact secHam_truncate_eq_of_band W Q (Λ n) hP1 hP2 hn

/-! ## 4. The truncated flows converge to the exact quantum-gravity flow -/

/-- **The numerical statement, with no hypothesis of resolvent convergence.**  Let `Λ n` be
any family of mode windows exhausting the modes.  Then the mode-truncated quantum-gravity
Hamiltonians and the exact one have unique self-adjoint realizations `S n` and `T`, the
resolvents of `S n` converge strongly to that of `T`, and the truncated unitary flows
converge to the exact quantum-gravity flow, uniformly on every compact time interval. -/
theorem qgOuterFock_truncation_flow_convergence (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        StrongResolventConvergence T S ∧
        ∀ (v : Sec ι) (T₀ : ℝ), 0 ≤ T₀ →
          TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
              (Set.Icc (-T₀) T₀) ∧
            ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  obtain ⟨T, -, hT, -⟩ := exists_stone_flow_of_esa (secHam W Q) secCore_dense
    (secHam_symmetricOn W Q) (secHam_esa_core W Q)
  have hSex : ∀ n : ℕ, ∃ Sn : UnboundedSelfAdjoint (Sec ι),
      IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) Sn.op := by
    intro n
    obtain ⟨Sn, -, hSn, -⟩ := exists_stone_flow_of_esa (secHam W (truncModes Q (Λ n)))
      secCore_dense (secHam_symmetricOn W (truncModes Q (Λ n)))
      (secHam_esa_core W (truncModes Q (Λ n)))
    exact ⟨Sn, hSn⟩
  choose S hS using hSex
  have hconv : ∀ x : secCore (ι := ι),
      Tendsto (fun n => secHam W (truncModes Q (Λ n)) x) atTop (𝓝 (secHam W Q x)) := by
    intro x
    have hev : (fun _ : ℕ => secHam W Q x)
        =ᶠ[atTop] fun n => secHam W (truncModes Q (Λ n)) x := by
      filter_upwards [secHam_truncate_eventually_eq W Q Λ hexh x] with n hn using hn.symm
    exact Tendsto.congr' hev tendsto_const_nhds
  have hres : StrongResolventConvergence T S :=
    strongResolventConvergence_of_core (secHam_esa_core W Q) hT hS hconv
  exact ⟨T, S, hT, hS, hres, fun v T₀ hT₀ =>
    ⟨trotterKato_tendstoUniformlyOn T S hres v hT₀, fun t => trotterKato_tendsto T S hres v t⟩⟩

/-! ## 5. The physical instance: the momentum cutoff of the continuum model -/

open BookProof.QgContinuumModeInstance

/-- **The momentum cutoff**: the window of all vielbein components with `|k|² ≤ n`.  This is
the discretization actually used in computations — the exact Fourier modes are kept, the
interactions above the cutoff are dropped. -/
def momWindow (n : ℕ) : Set CMode := {x | momSq x.1 ≤ (n : ℝ)}

/-- The momentum cutoffs exhaust the modes. -/
theorem momWindow_exhausts (F : Finset CMode) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ F, a ∈ momWindow n := by
  classical
  refine eventually_atTop.mpr ⟨F.sup fun a => ⌈momSq a.1⌉₊, fun n hn a ha => ?_⟩
  have h1 : momSq a.1 ≤ ((⌈momSq a.1⌉₊ : ℕ) : ℝ) := Nat.le_ceil _
  have h2 : (⌈momSq a.1⌉₊ : ℕ) ≤ F.sup fun a => ⌈momSq a.1⌉₊ :=
    Finset.le_sup (f := fun a : CMode => ⌈momSq a.1⌉₊) ha
  have h3 : ((⌈momSq a.1⌉₊ : ℕ) : ℝ) ≤ ((F.sup fun a => ⌈momSq a.1⌉₊ : ℕ) : ℝ) :=
    Nat.cast_le.mpr h2
  have h4 : ((F.sup fun a => ⌈momSq a.1⌉₊ : ℕ) : ℝ) ≤ (n : ℝ) := Nat.cast_le.mpr hn
  simp only [momWindow, Set.mem_setOf_eq]
  linarith

/-- **The physical numerical theorem.**  For the exact Fourier-mode quantum-gravity
Hamiltonian — no lattice, the full exponential Einstein-frame Starobinsky wall, the exact
torsion Gram matrix as vielbein self-interaction and the scalaron–vielbein coupling at an
arbitrary coupling constant `g` — the momentum-cutoff Hamiltonians have unique self-adjoint
realizations whose resolvents converge strongly to that of the exact Hamiltonian, and whose
unitary flows therefore converge to the exact quantum-gravity flow, uniformly on every
compact time interval.  No resolvent convergence is assumed: it is proved here for this
family. -/
theorem starobinsky_qgContinuum_momentumCutoff_flow_convergence (M alpha : ℝ)
    (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (S : ℕ → UnboundedSelfAdjoint (Sec CMode)),
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (qgContinuumModes g) (momWindow n))) (S n).op) ∧
        StrongResolventConvergence T S ∧
        ∀ (v : Sec CMode) (T₀ : ℝ), 0 ≤ T₀ →
          TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
              (Set.Icc (-T₀) T₀) ∧
            ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_truncation_flow_convergence (starobinskyWall M alpha halpha)
    (qgContinuumModes g) momWindow momWindow_exhausts

/-! ## 6. The statement in the Hashimoto shift-invert interface -/

open BookProof.HashimotoShiftInvert

/-- The **Hashimoto complex-shift resolvent** of a self-adjoint operator at the shift
`γ = i` is `−(A − i)⁻¹`: the two sign conventions (`A − iℓ` for the resolvent of
`ChapterStoneResolvent`, `γ − A` for the shift-invert of `ChapterHashimotoComplexShifts`)
differ by a sign. -/
theorem isShiftInvertC_neg_resCLM (T : UnboundedSelfAdjoint F) :
    IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) := by
  have hI : (Complex.I).im ≠ 0 := by simp
  have key : ∀ x : T.domain, cshiftMap T.op Complex.I x = -(T.shift 1 x) := by
    intro x
    rw [UnboundedSelfAdjoint.shift_apply]
    change Complex.I • (x : F) - T.op x = -(T.op x - (((1 : ℝ) : ℂ) * Complex.I) • (x : F))
    simp only [Complex.ofReal_one, one_mul]
    abel
  refine isShiftInvertC_of_rightInverse T.symmetric hI fun u => ?_
  have hmem : (-(T.resCLM 1)) u ∈ T.domain := by
    have h := T.resCLM_mem 1 u
    simp only [ContinuousLinearMap.neg_apply]
    exact T.domain.neg_mem h
  refine ⟨hmem, ?_⟩
  have hneg : (⟨(-(T.resCLM 1)) u, hmem⟩ : T.domain) = -(T.res 1 u) := Subtype.ext (by simp)
  rw [hneg, map_neg, key, neg_neg, T.shift_res one_ne_zero]

/-- **The numerical statement in the form the shift-invert (Hashimoto/SIRK) machinery of
this project consumes.**  The exact quantum-gravity Hamiltonian and each of its
mode truncations have a unique self-adjoint realization; each realization has a Hashimoto
shift-invert operator at the complex shift `γ = i`, namely `−(H − i)⁻¹`; and the truncated
shift-invert operators converge strongly to the exact one.  This is exactly the input of the
rational-Krylov (SIRK) layer, and by Trotter–Kato it yields convergence of the flows. -/
theorem qg_truncation_hashimoto_shiftInvert_tendsto (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) ∧
        (∀ n, IsShiftInvertC (S n).op Complex.I (-((S n).resCLM 1))) ∧
        ∀ u : Sec ι, Tendsto (fun n => -((S n).resCLM 1 u)) atTop (𝓝 (-(T.resCLM 1 u))) := by
  obtain ⟨T, S, hT, hS, hres, -⟩ := qgOuterFock_truncation_flow_convergence W Q Λ hexh
  exact ⟨T, S, hT, hS, isShiftInvertC_neg_resCLM T, fun n => isShiftInvertC_neg_resCLM (S n),
    fun u => (hres u).neg⟩

end

end BookProof.QgTruncationResolvent
