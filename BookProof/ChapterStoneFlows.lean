import Mathlib
import BookProof.ChapterStoneBridge
import BookProof.ChapterNavierStokesHashimoto
import BookProof.ChapterNavierStokesLagrangianKatoRellich
import BookProof.ChapterFockSecondQuantization

/-!
# The unitary flows of the Navier–Stokes and Yang–Mills Hamiltonians

`BookProof.ChapterStoneBridge` packages a *selected* self-adjoint extension into
the bundled `UnboundedSelfAdjoint` structure that Stone's theorem consumes.
This module runs that bridge on the three concrete Hamiltonians whose essential
self-adjointness (or Friedrichs selection) is already proved in this
development, producing in each case the complete unitary group `e^{-itA}` and
the Schrödinger equation it solves.

* `ns_stone_flow` — the **Eulerian Navier–Stokes fiber generator** `velCore A c`
  on `ℓ²(Vel)`, `Vel = Fin 3 → ℕ`, for an arbitrary real velocity-gradient
  matrix `A` and constant vector `c`.  The generator of the flow is the unique
  self-adjoint extension (the closure); no positivity is used, so there is no
  Friedrichs label — cf. `BookProof.NavierStokesFlow.NSHashimoto.ns_hashimoto_selects`.
* `lagrangian_stone_flow` — the **Lagrangian (parcel) transformed Hamiltonian**
  `ĥ_full = ½∑Pᵢ² + ν∑Qᵢ² + ∑fᵢDᵢ + C`, from essential self-adjointness of its
  core; and `diagKR_stone_flow`, the concrete `ℓ²(ℕ)` instance with a genuinely
  unbounded drift, where the hypothesis is discharged by Kato–Rellich.
* `ym_fock_stone_flow` — the **second-quantized Yang–Mills Hamiltonian**
  `dΓ(½Σπ² + ½ΣB²)` on the Fock space over the Gauss–polynomial core of
  `L²(ℝ⁹⁹)`: here the extension *is* positive, so the flow is that of the
  Friedrichs extension.

In each case the conclusion is the `BookProof.StoneBridge.IsStoneFlow` package:
`U 0 = 1`, the group law `U (s + t) = U s ∘ U t`, isometry of every `U t` (hence
unitarity, the group being invertible), and the Schrödinger equation
`d/dt (U t x) = -i A (U t x)` for `x` in the domain — global in `t`, i.e. the
operator flow exists for all times.

## Honest boundary

Unchanged from the rest of the threads.  Nothing here claims global regularity
of the classical Navier–Stokes PDE (Contention D5) or a Yang–Mills mass gap; the
Navier–Stokes setting is the abstract sequence-space realization of the fiber
Hamiltonian, not the differential operator on `L²(du₁du₂du₃)`.

Everything is `sorry`-free and `axiom`-free.
-/

open Filter Topology

namespace BookProof.StoneFlows

open BookProof.FarisLavine BookProof.EsaClosure BookProof.YangMillsFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge
open BookProof.HermiteGalerkin

/-! ## The Eulerian Navier–Stokes flow -/

open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LagrangianEsa
open BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.NSHashimoto

/-- **The Navier–Stokes fiber generator generates a complete unitary flow.**
The coupled three-component Hamiltonian is essentially self-adjoint on the
finite-mode core of `ℓ²(Vel)`, hence has a unique self-adjoint extension, and
Stone's theorem turns that extension into the global unitary group `e^{-itA}`
solving the Schrödinger equation on the domain. -/
theorem ns_stone_flow (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (U : ℝ → (L2I Vel →L[ℂ] L2I Vel)),
      IsSelfAdjointExtension (velCore A c) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (velCore A c) velCore_dense (velCore_symmetricOn A c) (velCore_esa A c)

/-! ## The Lagrangian Navier–Stokes flow -/

section Lagrangian

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)

/-- **The transformed (Lagrangian) Navier–Stokes Hamiltonian generates a
complete unitary flow**, given essential self-adjointness of its core — which
`BookProof.NavierStokesFlow.LagrangianKatoRellich.hFull_essentiallySelfAdjointOn`
supplies from the positivity of the second-order part alone. -/
theorem lagrangian_stone_flow (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L)) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)),
      IsSelfAdjointExtension (lagrangianCore L) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (lagrangianCore L) L.dense (lagrangianCore_symmetricOn L) hesa

end Lagrangian

/-- **The unbounded `ℓ²(ℕ)` instance flows too.**  Its drift is genuinely
unbounded (`diagKR_drift_not_bounded`), so the bounded Kato–Rellich theorem does
not apply; the relative bound gained from the Lagrangian positivity does. -/
theorem diagKR_stone_flow :
    ∃ (T : UnboundedSelfAdjoint L2N) (U : ℝ → (L2N →L[ℂ] L2N)),
      IsSelfAdjointExtension (lagrangianCore diagKR) T.op ∧ IsStoneFlow T U :=
  lagrangian_stone_flow diagKR diagKR_hFull_essentiallySelfAdjointOn

/-! ## The Yang–Mills flow -/

open BookProof.FockSecondQuantization

/-- **The second-quantized Yang–Mills Hamiltonian generates a complete unitary
flow.**  Here the selected extension is the *positive* (Friedrichs) one, so the
flow is the Schrödinger evolution generated by it.  No mass gap is claimed. -/
theorem ym_fock_stone_flow (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock) (T : UnboundedSelfAdjoint Fock)
      (U : ℝ → (Fock →L[ℂ] Fock)),
      IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A ∧
        T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U := by
  obtain ⟨Dom, A, hA⟩ := ym_fock_friedrichs_extension e fabc
  obtain ⟨T, U, hdom, hop, hflow⟩ :=
    exists_stone_flow_of_positive (Hc := dGammaOp (ymFockCol e fabc))
      finiteOccupation_dense hA
  exact ⟨Dom, A, T, U, hA, hdom, hop, hflow⟩

end BookProof.StoneFlows
