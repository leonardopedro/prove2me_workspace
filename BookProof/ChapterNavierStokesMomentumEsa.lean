import Mathlib
import BookProof.ChapterNavierStokesIkebeKato
import BookProof.ChapterNavierStokesFarisLavineLift

/-!
# Essential self-adjointness of the Navier–Stokes Hamiltonian, momentum representation

`BookProof.ChapterNavierStokesIkebeKato` proved, for an arbitrary index set, the
three analytic facts that the Faris–Lavine route needs about the comparison
operator: positivity, surjectivity of `N + 1` on the maximal domain, and the
fact that the finite-mode states are an operator core.  Here those facts are
specialised twice.

**1. One particle.**  In the fiber momentum representation the comparison
operator `n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I` is multiplication by the symbol
`σ(k) = ∑ᵢ pᵢ(k)² + ∑ᵢ qᵢ(k)² + 1 ≥ 1` (`nsSymbol`), which is exactly the operator
`ComparisonData.comparison` of `BookProof.ChapterNavierStokesFarisLavineLift`
(`nsComparison_restrict_eq`).  Consequently:

* `nsComparison_ikebeKato` — the comparison operator is essentially self-adjoint on
  the finite-mode core, now *via* Faris–Lavine and the maximal-domain analysis,
  and `nsComparison_selfAdjoint_maxDom` on its maximal domain;
* `ns_hamiltonian_essentiallySelfAdjointOn_core` — **the Navier–Stokes Hamiltonian
  of the fiber is essentially self-adjoint on the finite-mode core** as soon as it
  obeys the two Faris–Lavine inequalities relative to `n`.  Nothing else is
  assumed: the Faris–Lavine criterion is the theorem
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine` and the
  Ikebe–Kato-type input is proved.

**2. The Fock space.**  In the momentum representation the bosonic Fock space over
the fiber is `ℓ²` over the set `Config = ℕ →₀ ℕ` of occupation-number
configurations, and the second quantization `N̂ = dΓ(n) + I` is again a
*multiplication* operator, by the total-energy symbol
`Σ(α) = ∑ₖ α(k) n(k) + 1` (`fockSymbol`).  Hence the whole analysis applies
verbatim with `ι = Config`:

* `fockSymbol_add` — `dΓ` is additive over particles, `fockSymbol_ge_one` — `N̂ ≥ I`;
* `fockComparison_ikebeKato` — the Fock comparison operator is essentially
  self-adjoint on the finite-configuration core;
* `fock_ns_hamiltonian_essentiallySelfAdjointOn_core` and its deficiency-predicate
  form `fock_ns_hamiltonian_hasZeroDeficiencyOn` — **the second-quantized
  Navier–Stokes Hamiltonian is essentially self-adjoint** on that core, given the
  two Faris–Lavine inequalities.

## What is and is not claimed

The two Faris–Lavine inequalities (`hrel`, `hcomm`) remain hypotheses on the
Hamiltonian: they are the statements that the Navier–Stokes Hamiltonian is
`N`-bounded and that its form commutator with `N` is `N`-dominated, and they are
not verified here for any continuum operator.  Everything else on the route —
the criterion itself and the Ikebe–Kato-type input — is proved.  Global existence
for the Navier–Stokes equation is not claimed anywhere.

Note also that the *earlier* rendering of the criterion in
`BookProof.ChapterNavierStokesFlow` (relative bound plus commutator bound, with no
positivity and no surjectivity of `N + 1`) is refutable —
`BookProof.FarisLavine.not_farisLavine_criterion_of_relative_bound` — which is
precisely why the theorems below are stated with the maximal domain of a
non-negative symbol.
-/

namespace BookProof.NavierStokesFlow

namespace MomentumEsa

open LpNat FarisLavine IkebeKato FarisLavineLift DiagonalEsa

/-! ## Transfer to the deficiency predicate of the Navier–Stokes chapters -/

variable {ι : Type*}

/-- If the restriction of `H` to the finite-mode core maps that core into itself,
essential self-adjointness on the core is the predicate `HasZeroDeficiencyOn`
used throughout the Navier–Stokes chapters. -/
theorem hasZeroDeficiencyOn_of_esa_core {c : ι → ℝ} (H : maxDom c →ₗ[ℂ] L2I ι)
    (Hc : lpFiniteModes ι →ₗ[ℂ] lpFiniteModes ι)
    (hHc : ∀ x : lpFiniteModes ι, ((Hc x : lpFiniteModes ι) : L2I ι)
      = H (Submodule.inclusion (finiteModes_le_maxDom c) x))
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes ι)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom c)))) :
    HasZeroDeficiencyOn (lpFiniteModes ι) Hc := by
  refine (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn (lpFiniteModes ι) Hc).1 ?_
  have hEq : (lpFiniteModes ι).subtype.comp Hc
      = H.comp (Submodule.inclusion (finiteModes_le_maxDom c)) :=
    LinearMap.ext fun x => hHc x
  rw [hEq]
  exact hesa

/-! ## One particle: the Navier–Stokes comparison symbol -/

/-- The classical symbol of the one-particle comparison operator
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I` in the momentum representation: `πᵢ` is multiplication
by the momentum symbol `pᵢ`, `Vᵢ` multiplication by the advection symbol `qᵢ`. -/
def nsSymbol (d : ℕ) (p q : Fin d → ℕ → ℝ) : ℕ → ℝ :=
  fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1

theorem nsSymbol_ge_one (d : ℕ) (p q : Fin d → ℕ → ℝ) (k : ℕ) : 1 ≤ nsSymbol d p q k := by
  have h1 : (0 : ℝ) ≤ ∑ i, p i k ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ i, q i k ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  simp only [nsSymbol]
  linarith

theorem nsSymbol_nonneg (d : ℕ) (p q : Fin d → ℕ → ℝ) (k : ℕ) : 0 ≤ nsSymbol d p q k :=
  le_trans zero_le_one (nsSymbol_ge_one d p q k)

/-- **The maximal-domain comparison operator restricts to the comparison operator
of the fiber.**  On the finite-mode core, multiplication by `nsSymbol` is exactly
`ComparisonData.comparison` for the momentum representation — so the operator
analysed here is the one the Faris–Lavine lift is about. -/
theorem nsComparison_restrict_eq (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagMax (nsSymbol d p q)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (nsSymbol d p q)))
      = (lpFiniteModes ℕ).subtype.comp (diagComparisonData d p q).comparison := by
  refine LinearMap.ext fun f => lp.ext (funext fun k => ?_)
  rw [LinearMap.comp_apply, LinearMap.comp_apply, diagMax_coe, diagComparison_eq]
  simp [DiagonalEsa.diagFun, nsSymbol]

/-- **The comparison operator of the fiber is self-adjoint on its maximal
domain** — the Ikebe–Kato-type input, in the momentum representation. -/
theorem nsComparison_selfAdjoint_maxDom (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    EssentiallySelfAdjointOn (maxDom (nsSymbol d p q)) (diagMax (nsSymbol d p q)) :=
  diagMax_essentiallySelfAdjointOn _ (nsSymbol_nonneg d p q)

/-- `N ≥ I` on the maximal domain, unconditionally: the potential term is a
square. -/
theorem nsComparison_quadForm_ge (d : ℕ) (p q : Fin d → ℕ → ℝ)
    (x : maxDom (nsSymbol d p q)) :
    ‖(x : L2I ℕ)‖ ^ 2 ≤ quadForm (diagMax (nsSymbol d p q)) x :=
  diagMax_quadForm_ge_norm_sq _ (nsSymbol_ge_one d p q) x

/-- **The Ikebe–Kato statement for the Navier–Stokes fiber comparison operator**:
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I` is essentially self-adjoint on the finite-mode core.
Proved here through the Faris–Lavine theorem and the maximal-domain analysis,
independently of the eigenvector argument of
`FarisLavineLift.diagComparison_hasZeroDeficiencyOn`. -/
theorem nsComparison_ikebeKato (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((lpFiniteModes ℕ).subtype.comp (diagComparisonData d p q).comparison) := by
  rw [← nsComparison_restrict_eq]
  exact ikebeKato_momentum _ (nsSymbol_nonneg d p q)

/-- **The one-particle Navier–Stokes Hamiltonian is essentially self-adjoint on
the finite-mode core** as soon as it satisfies the two Faris–Lavine inequalities
relative to the comparison operator `n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`. -/
theorem ns_hamiltonian_essentiallySelfAdjointOn_core (d : ℕ) (p q : Fin d → ℕ → ℝ)
    (H : maxDom (nsSymbol d p q) →ₗ[ℂ] L2I ℕ) (a b cst : ℝ)
    (hH : SymmetricOn (maxDom (nsSymbol d p q)) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom (nsSymbol d p q),
      ‖H x‖ ^ 2 ≤ a * ‖diagMax (nsSymbol d p q) x‖ ^ 2 + b * ‖(x : L2I ℕ)‖ ^ 2)
    (hcomm : ∀ x : maxDom (nsSymbol d p q),
      |commForm H (diagMax (nsSymbol d p q)) x|
        ≤ cst * quadForm (diagMax (nsSymbol d p q)) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom (nsSymbol d p q)))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds _ (nsSymbol_nonneg d p q)
    H a b cst hH hcst hrel hcomm

/-! ## The Fock space in the occupation-number representation -/

/-- An occupation-number configuration of the fiber momentum modes: finitely many
modes are occupied, each by finitely many particles.  `ℓ²(Config)` is the bosonic
Fock space over the fiber `ℓ²(ℕ)` in the momentum representation. -/
abbrev Config := ℕ →₀ ℕ

/-- **The second quantization `N̂ = dΓ(n) + I` is a multiplication operator** in
the occupation-number representation, by the total-energy symbol
`Σ(α) = ∑ₖ α(k) n(k) + 1`. -/
def fockSymbol (n : ℕ → ℝ) : Config → ℝ := fun a => (a.sum fun k m => (m : ℝ) * n k) + 1

@[simp] theorem fockSymbol_zero (n : ℕ → ℝ) : fockSymbol n 0 = 1 := by
  simp [fockSymbol]

/-- `dΓ` is additive over particles: the energy of a superposed configuration is
the sum of the energies (the `+1` of the identity being counted once). -/
theorem fockSymbol_add (n : ℕ → ℝ) (a b : Config) :
    fockSymbol n (a + b) + 1 = fockSymbol n a + fockSymbol n b := by
  have hsum : (Finsupp.sum (a + b) fun k m => (m : ℝ) * n k)
      = (Finsupp.sum a fun k m => (m : ℝ) * n k) + Finsupp.sum b fun k m => (m : ℝ) * n k :=
    Finsupp.sum_add_index' (fun k => by simp) (fun k m₁ m₂ => by push_cast; ring)
  simp only [fockSymbol]
  rw [hsum]
  ring

/-- For a non-negative one-particle symbol the Fock symbol is `≥ 1`: `N̂ ≥ I`
survives second quantization. -/
theorem fockSymbol_ge_one (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) (a : Config) :
    1 ≤ fockSymbol n a := by
  have h : (0 : ℝ) ≤ a.sum fun k m => (m : ℝ) * n k :=
    Finset.sum_nonneg fun k _ => mul_nonneg (Nat.cast_nonneg _) (hn k)
  simp only [fockSymbol]
  linarith

theorem fockSymbol_nonneg (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) (a : Config) :
    0 ≤ fockSymbol n a :=
  le_trans zero_le_one (fockSymbol_ge_one n hn a)

/-- **`N̂ + 1` is surjective onto the Fock space** from the maximal domain of
`dΓ(n) + I`. -/
theorem fockComparison_add_one_surjective (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) (f : L2I Config) :
    ∃ x : maxDom (fockSymbol n), (diagMax (fockSymbol n) x : L2I Config) + (x : L2I Config) = f :=
  diagMax_add_one_surjective _ (fockSymbol_nonneg n hn) f

/-- **`N̂ ≥ I` on the Fock space.** -/
theorem fockComparison_quadForm_ge (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k)
    (x : maxDom (fockSymbol n)) :
    ‖(x : L2I Config)‖ ^ 2 ≤ quadForm (diagMax (fockSymbol n)) x :=
  diagMax_quadForm_ge_norm_sq _ (fockSymbol_ge_one n hn) x

/-- **The finite-configuration states are a core for `N̂`.** -/
theorem fockComparison_core (n : ℕ → ℝ) (x : maxDom (fockSymbol n)) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : maxDom (fockSymbol n), (y : L2I Config) ∈ lpFiniteModes Config ∧
      ‖(y : L2I Config) - (x : L2I Config)‖ < ε ∧
        ‖diagMax (fockSymbol n) y - diagMax (fockSymbol n) x‖ < ε :=
  exists_finiteModes_graph_approx _ x ε hε

/-- **The Fock comparison operator `N̂ = dΓ(n) + I` is essentially self-adjoint on
the finite-configuration core** — the Fock-space form of the Ikebe–Kato input. -/
theorem fockComparison_ikebeKato (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) :
    EssentiallySelfAdjointOn (lpFiniteModes Config)
      ((diagMax (fockSymbol n)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSymbol n)))) :=
  ikebeKato_momentum _ (fockSymbol_nonneg n hn)

/-- **Essential self-adjointness of the second-quantized Navier–Stokes
Hamiltonian.**  In the occupation-number (momentum) representation of the Fock
space over the fiber, let `N̂ = dΓ(n) + I` be the second quantization of a
non-negative one-particle symbol — for the Navier–Stokes fiber,
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`, `nsSymbol` — and let `Ĥ` be any symmetric operator on
the maximal domain of `N̂` with the relative bound
`‖Ĥψ‖² ≤ a‖N̂ψ‖² + b‖ψ‖²` and the commutator form bound `± i[Ĥ, N̂] ≤ c N̂`.  Then
`Ĥ` is essentially self-adjoint on the finite-particle, finite-mode core.

The Faris–Lavine criterion is **not** a hypothesis: it is the theorem
`BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`.  Neither is
the Ikebe–Kato input: positivity, surjectivity of `N̂ + 1` and the core property
are `fockComparison_quadForm_ge`, `fockComparison_add_one_surjective` and
`fockComparison_core`. -/
theorem fock_ns_hamiltonian_essentiallySelfAdjointOn_core (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k)
    (H : maxDom (fockSymbol n) →ₗ[ℂ] L2I Config) (a b cst : ℝ)
    (hH : SymmetricOn (maxDom (fockSymbol n)) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom (fockSymbol n),
      ‖H x‖ ^ 2 ≤ a * ‖diagMax (fockSymbol n) x‖ ^ 2 + b * ‖(x : L2I Config)‖ ^ 2)
    (hcomm : ∀ x : maxDom (fockSymbol n),
      |commForm H (diagMax (fockSymbol n)) x| ≤ cst * quadForm (diagMax (fockSymbol n)) x) :
    EssentiallySelfAdjointOn (lpFiniteModes Config)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom (fockSymbol n)))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds _ (fockSymbol_nonneg n hn)
    H a b cst hH hcst hrel hcomm

/-- The same conclusion in the deficiency-predicate form used by the
Navier–Stokes chapters, for a Hamiltonian that preserves the core. -/
theorem fock_ns_hamiltonian_hasZeroDeficiencyOn (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k)
    (H : maxDom (fockSymbol n) →ₗ[ℂ] L2I Config)
    (Hc : lpFiniteModes Config →ₗ[ℂ] lpFiniteModes Config)
    (hHc : ∀ x : lpFiniteModes Config, ((Hc x : lpFiniteModes Config) : L2I Config)
      = H (Submodule.inclusion (finiteModes_le_maxDom (fockSymbol n)) x))
    (a b cst : ℝ)
    (hH : SymmetricOn (maxDom (fockSymbol n)) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom (fockSymbol n),
      ‖H x‖ ^ 2 ≤ a * ‖diagMax (fockSymbol n) x‖ ^ 2 + b * ‖(x : L2I Config)‖ ^ 2)
    (hcomm : ∀ x : maxDom (fockSymbol n),
      |commForm H (diagMax (fockSymbol n)) x| ≤ cst * quadForm (diagMax (fockSymbol n)) x) :
    HasZeroDeficiencyOn (lpFiniteModes Config) Hc :=
  hasZeroDeficiencyOn_of_esa_core H Hc hHc
    (fock_ns_hamiltonian_essentiallySelfAdjointOn_core n hn H a b cst hH hcst hrel hcomm)

/-- The Navier–Stokes instance of the Fock symbol: the second quantization of the
fiber comparison operator `n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`. -/
noncomputable def nsFockSymbol (d : ℕ) (p q : Fin d → ℕ → ℝ) : Config → ℝ :=
  fockSymbol (nsSymbol d p q)

/-- **The Navier–Stokes Fock comparison operator is essentially self-adjoint on
the finite-configuration core.** -/
theorem nsFockComparison_ikebeKato (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Config)
      ((diagMax (nsFockSymbol d p q)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (nsFockSymbol d p q)))) :=
  fockComparison_ikebeKato _ (nsSymbol_nonneg d p q)

/-- **The assembled statement.**  The second-quantized Navier–Stokes Hamiltonian
in the momentum representation is essentially self-adjoint on the
finite-particle, finite-mode core, given exactly the two Faris–Lavine
inequalities relative to `N̂ = dΓ(∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I) + I`. -/
theorem navierStokes_fock_hamiltonian_essentiallySelfAdjointOn_core (d : ℕ)
    (p q : Fin d → ℕ → ℝ)
    (H : maxDom (nsFockSymbol d p q) →ₗ[ℂ] L2I Config) (a b cst : ℝ)
    (hH : SymmetricOn (maxDom (nsFockSymbol d p q)) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom (nsFockSymbol d p q),
      ‖H x‖ ^ 2 ≤ a * ‖diagMax (nsFockSymbol d p q) x‖ ^ 2 + b * ‖(x : L2I Config)‖ ^ 2)
    (hcomm : ∀ x : maxDom (nsFockSymbol d p q),
      |commForm H (diagMax (nsFockSymbol d p q)) x|
        ≤ cst * quadForm (diagMax (nsFockSymbol d p q)) x) :
    EssentiallySelfAdjointOn (lpFiniteModes Config)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom (nsFockSymbol d p q)))) :=
  fock_ns_hamiltonian_essentiallySelfAdjointOn_core _ (nsSymbol_nonneg d p q)
    H a b cst hH hcst hrel hcomm

end MomentumEsa

end BookProof.NavierStokesFlow
