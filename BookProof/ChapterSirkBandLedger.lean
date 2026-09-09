import Mathlib
import BookProof.ChapterSirkCertificateReader
import BookProof.ChapterBandEnclosure

/-!
# QYM-1 task 1 — the emitted bands are *nested compatible* enclosures

Plan item **QYM-1, task 1** of `CONSOLIDATED_PLAN.md`: "prove that the certified
bands the kernel emits are *nested compatible* enclosures in the sense
`BandEnclosure` requires (same operator, mesh refinement) — a Lean statement over
the band interface (`ChapterSirkCertificateReader` / `ChapterBandEnclosure`), not
over f64 outputs."

`ChapterBandEnclosure` consumes its bands through one predicate,
`BandEnclosure.NestedBands lo hi`, and everything downstream
(`band_enclosure_of_nested`, `ritz_band_enclosure_of_nested`,
`friedrichs_form_gap_of_nested_ritz_bands`) is stated for functions
`lo hi : ℕ → ℝ`.  What the emitter actually produces is a *finite* list of
records, one per truncation order.  This chapter is the missing adapter, and the
proof that the adapter's output is nested.

## The ledger

* `BandRecord` — one emitted band: the operator tag `op` (constructor / version /
  coupling / truncation / enclosure-convention identity), the mesh order `order`,
  and the two endpoints `lo`, `hi` as **exact decimals** (`Decimal` of
  `ChapterSirkCertificateReader`; no `Float` occurs anywhere in this file).
* `parseBandLine`, `parseLedger` — the reader for the NDJSON band stream, built
  from the exact-decimal parser of the certificate reader.
* `ledgerLo`, `ledgerHi : List BandRecord → ℕ → ℝ` — the adapter: the order-`m`
  endpoints, extended by the last recorded band beyond the end of the ledger (a
  finite ledger says nothing after its last order, so it repeats it).

## The compatibility conditions, and the theorem

`LedgerWf L` is a **decidable** conjunction of exactly the conditions the plan
names, checked on the recorded exact decimals:

* the ledger is non-empty;
* **same operator**: every record carries the same operator tag;
* the orders are `0, 1, 2, …` in sequence (no gaps, no reordering);
* **mesh refinement**: `lo` is nondecreasing and `hi` is nonincreasing along the
  ledger;
* each band encloses (`lo ≤ hi`).

`nestedBands_of_wf` : a well-formed ledger yields
`NestedBands (ledgerLo L) (ledgerHi L)`.  Composing with `ChapterBandEnclosure`:

* `ritz_band_enclosure_of_ledger` — for a bounded positive self-adjoint
  one-particle operator, every ledger band encloses `sInf (spectrum ℝ A)`;
* `friedrichs_form_gap_of_ledger` — for the unbounded Hamiltonian on the
  finite-mode core, a ledger whose first band has lower end `≥ μ` gives
  `⟪y, A y⟫ ≥ μ‖y‖²` on the whole domain of the Friedrichs extension the
  Hashimoto shift-invert selects;
* `friedrichs_form_gap_of_ledger_lo_zero` — the same, with `μ` read off the
  ledger's first band.

## Honest boundary

* Nesting and the "same operator" property are properties of the **recorded
  numbers and metadata**, and that is exactly what this chapter proves.  That the
  order-`m` Ritz value really lies in the order-`m` band is the analytic /
  finite-precision input (`ChapterSirkFinitePrecision`, `ChapterSirkCertifiedGap`),
  carried here as the hypothesis `hritz` — it is not established by inspecting the
  ledger.
* A **finite** ledger cannot certify band collapse: beyond its last order the
  extension repeats the last band, so the widths are eventually constant
  (`ledger_width_eventually_const`) and tend to `0` only if the last recorded
  width is `0` (`ledger_width_tendsto_zero_iff`).  The theorems used above are
  precisely the ones that do *not* need vanishing widths; the collapse remains the
  analytic input (`ChapterH6.sirk_error_decay_exponential`).
* No floating-point value is read: the endpoints are exact decimals, compared
  through integer cross-multiplication (`Decimal.leB`).

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SirkBandLedger

open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

/-! ## 1. Exact comparison of decimals -/

/-- Comparison of exact decimals by integer cross-multiplication: no division, no
`Float`, and cheap for the kernel to check. -/
def Decimal.leB (d e : Decimal) : Prop :=
  d.mant * 10 ^ e.exp ≤ e.mant * 10 ^ d.exp

instance (d e : Decimal) : Decidable (Decimal.leB d e) := by
  unfold Decimal.leB; infer_instance

/-- Cross-multiplication decides the order of the rational values. -/
theorem Decimal.leB_iff (d e : Decimal) : Decimal.leB d e ↔ d.toQ ≤ e.toQ := by
  have hd : (0 : ℚ) < (10 : ℚ) ^ d.exp := by positivity
  have he : (0 : ℚ) < (10 : ℚ) ^ e.exp := by positivity
  rw [Decimal.toQ, Decimal.toQ, div_le_div_iff₀ hd he, Decimal.leB]
  constructor
  · intro h
    have : ((d.mant * 10 ^ e.exp : ℤ) : ℚ) ≤ ((e.mant * 10 ^ d.exp : ℤ) : ℚ) := by
      exact_mod_cast h
    push_cast at this
    linarith
  · intro h
    have : ((d.mant * 10 ^ e.exp : ℤ) : ℚ) ≤ ((e.mant * 10 ^ d.exp : ℤ) : ℚ) := by
      push_cast
      linarith
    exact_mod_cast this

/-! ## 2. The band ledger -/

/-- One emitted band: the operator identity tag, the mesh/truncation order, and the
two endpoints as exact decimals. -/
structure BandRecord where
  /-- The operator identity: constructor / version / coupling / truncation /
  enclosure convention, as emitted.  "Same operator" is equality of this tag. -/
  op : List Char
  /-- The mesh / truncation order this band was computed at. -/
  order : ℕ
  /-- The lower endpoint of the certified band. -/
  lo : Decimal
  /-- The upper endpoint of the certified band. -/
  hi : Decimal
deriving DecidableEq, Repr

instance : Inhabited BandRecord := ⟨⟨[], 0, ⟨0, 0⟩, ⟨0, 0⟩⟩⟩

/-- Parse one emitted band line, e.g.
`{"op":"qym3d/v1","order":0,"lo":0.90,"hi":2.40}`.  A band whose lower endpoint
exceeds its upper endpoint is rejected rather than trusted. -/
def parseBandLine (line : List Char) : Option BandRecord := do
  let opC ← fieldChars line "op".toList
  let ordC ← fieldChars line "order".toList
  let loC ← fieldChars line "lo".toList
  let hiC ← fieldChars line "hi".toList
  let ord ← parseNatDigits (ordC.filter (fun c => c != '"'))
  let lo ← parseDec loC
  let hi ← parseDec hiC
  if Decimal.leB lo hi then
    some ⟨opC.filter (fun c => c != '"'), ord, lo, hi⟩
  else
    none

/-- **The reader for the band stream.**  Every line that is a well-formed band
record is read; anything else (a header line, a trailing newline) is ignored. -/
def parseLedger (s : String) : List BandRecord :=
  (splitLines s.toList).filterMap parseBandLine

/-- The record the ledger supplies at order `m`: the `m`-th record while the
ledger lasts, its last record afterwards. -/
def recAt (L : List BandRecord) (m : ℕ) : BandRecord :=
  L.getD (min m (L.length - 1)) default

/-- The order-`m` lower endpoint, exactly. -/
def loQ (L : List BandRecord) (m : ℕ) : ℚ := (recAt L m).lo.toQ

/-- The order-`m` upper endpoint, exactly. -/
def hiQ (L : List BandRecord) (m : ℕ) : ℚ := (recAt L m).hi.toQ

/-- The order-`m` lower endpoint, as the real-valued band function
`ChapterBandEnclosure` consumes. -/
def ledgerLo (L : List BandRecord) (m : ℕ) : ℝ := ((loQ L m : ℚ) : ℝ)

/-- The order-`m` upper endpoint, as the real-valued band function
`ChapterBandEnclosure` consumes. -/
def ledgerHi (L : List BandRecord) (m : ℕ) : ℝ := ((hiQ L m : ℚ) : ℝ)

/-! ## 3. Nested compatibility, decidably checked -/

/-- **The compatibility conditions**, as a decidable check on the emitted data:
non-empty; one and the same operator tag throughout; the orders in sequence
`0, 1, 2, …`; the lower endpoints nondecreasing and the upper endpoints
nonincreasing (mesh refinement); and every band an enclosure. -/
def ledgerWfB (L : List BandRecord) : Bool :=
  !L.isEmpty &&
  L.all (fun r => r.op == (L.getD 0 default).op) &&
  (List.range L.length).all (fun i => (L.getD i default).order == i) &&
  (List.range (L.length - 1)).all (fun i =>
      decide (Decimal.leB (L.getD i default).lo (L.getD (i + 1) default).lo) &&
      decide (Decimal.leB (L.getD (i + 1) default).hi (L.getD i default).hi)) &&
  L.all (fun r => decide (Decimal.leB r.lo r.hi))

/-- A well-formed ledger. -/
def LedgerWf (L : List BandRecord) : Prop := ledgerWfB L = true

instance (L : List BandRecord) : Decidable (LedgerWf L) := by
  unfold LedgerWf; infer_instance

theorem ledgerWf_ne_nil {L : List BandRecord} (h : LedgerWf L) : L ≠ [] := by
  intro hnil
  rw [LedgerWf, ledgerWfB, hnil] at h
  simp at h

/-- **Same operator.**  Every record of a well-formed ledger carries the same
operator tag: the bands are enclosures of one and the same object. -/
theorem ledgerWf_sameOp {L : List BandRecord} (h : LedgerWf L) {r : BandRecord}
    (hr : r ∈ L) : r.op = (L.getD 0 default).op := by
  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, beq_iff_eq] at h
  exact h.1.1.1.2 r hr

/-- The orders recorded are `0, 1, 2, …`: a mesh refinement sequence with no gaps
and no reordering. -/
theorem ledgerWf_order {L : List BandRecord} (h : LedgerWf L) {i : ℕ}
    (hi : i < L.length) : (L.getD i default).order = i := by
  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, List.mem_range, beq_iff_eq] at h
  exact h.1.1.2 i hi

/-- Every recorded band is an enclosure. -/
theorem ledgerWf_enclosing {L : List BandRecord} (h : LedgerWf L) {r : BandRecord}
    (hr : r ∈ L) : r.lo.toQ ≤ r.hi.toQ := by
  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, decide_eq_true_eq] at h
  exact (Decimal.leB_iff _ _).1 (h.2 r hr)

/-- **Mesh refinement**, step form: the lower endpoints do not decrease and the
upper endpoints do not increase from one recorded order to the next. -/
theorem ledgerWf_step {L : List BandRecord} (h : LedgerWf L) {i : ℕ}
    (hi : i + 1 < L.length) :
    (L.getD i default).lo.toQ ≤ (L.getD (i + 1) default).lo.toQ ∧
      (L.getD (i + 1) default).hi.toQ ≤ (L.getD i default).hi.toQ := by
  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, List.mem_range, decide_eq_true_eq] at h
  have hmem : i < L.length - 1 := by omega
  obtain ⟨h1, h2⟩ := h.1.2 i hmem
  exact ⟨(Decimal.leB_iff _ _).1 h1, (Decimal.leB_iff _ _).1 h2⟩

/-- Beyond the last recorded order the ledger repeats its last band. -/
theorem recAt_of_ge {L : List BandRecord} {m : ℕ} (hm : L.length - 1 ≤ m) :
    recAt L m = recAt L (L.length - 1) := by
  simp [recAt, min_eq_right hm]

theorem recAt_of_lt {L : List BandRecord} {m : ℕ} (hm : m < L.length) :
    recAt L m = L.getD m default := by
  have h : min m (L.length - 1) = m := min_eq_left (by omega)
  simp [recAt, h]

/-- The lower endpoints of a well-formed ledger are nondecreasing in the order. -/
theorem loQ_monotone {L : List BandRecord} (h : LedgerWf L) : Monotone (loQ L) := by
  refine monotone_nat_of_le_succ (fun m => ?_)
  simp only [loQ]
  by_cases hm : m + 1 < L.length
  · rw [recAt_of_lt (show m < L.length by omega), recAt_of_lt hm]
    exact (ledgerWf_step h hm).1
  · rw [recAt_of_ge (show L.length - 1 ≤ m by omega),
      recAt_of_ge (show L.length - 1 ≤ m + 1 by omega)]

/-- The upper endpoints of a well-formed ledger are nonincreasing in the order. -/
theorem hiQ_antitone {L : List BandRecord} (h : LedgerWf L) : Antitone (hiQ L) := by
  refine antitone_nat_of_succ_le (fun m => ?_)
  simp only [hiQ]
  by_cases hm : m + 1 < L.length
  · rw [recAt_of_lt (show m < L.length by omega), recAt_of_lt hm]
    exact (ledgerWf_step h hm).2
  · rw [recAt_of_ge (show L.length - 1 ≤ m by omega),
      recAt_of_ge (show L.length - 1 ≤ m + 1 by omega)]

/-- **QYM-1 task 1.**  The emitted bands of a well-formed ledger are *nested
compatible* enclosures in exactly the sense `ChapterBandEnclosure` requires. -/
theorem nestedBands_of_wf {L : List BandRecord} (h : LedgerWf L) :
    NestedBands (ledgerLo L) (ledgerHi L) := by
  intro m
  refine Set.Icc_subset_Icc ?_ ?_
  · simp only [ledgerLo]
    exact_mod_cast loQ_monotone h (Nat.le_succ m)
  · simp only [ledgerHi]
    exact_mod_cast hiQ_antitone h (Nat.le_succ m)

/-- Every ledger band is an enclosure (`lo ≤ hi`) at every order. -/
theorem ledgerLo_le_ledgerHi {L : List BandRecord} (h : LedgerWf L) (m : ℕ) :
    ledgerLo L m ≤ ledgerHi L m := by
  have hne := ledgerWf_ne_nil h
  have hlen : 0 < L.length := List.length_pos_iff.mpr hne
  have hlt : min m (L.length - 1) < L.length := lt_of_le_of_lt (min_le_right _ _) (by omega)
  have hmem : recAt L m ∈ L := by
    simp only [recAt, List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hlt]
    exact List.getElem_mem hlt
  have hle := ledgerWf_enclosing h hmem
  simp only [ledgerLo, ledgerHi, loQ, hiQ]
  exact_mod_cast hle

/-! ## 4. What a finite ledger can and cannot certify -/

/-- Beyond the last recorded order the band width is constant: a finite ledger
carries no information about collapse. -/
theorem ledger_width_eventually_const (L : List BandRecord) {m : ℕ}
    (hm : L.length - 1 ≤ m) :
    ledgerHi L m - ledgerLo L m
      = ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1) := by
  simp [ledgerHi, ledgerLo, hiQ, loQ, recAt_of_ge hm]

/-- The ledger widths tend to `0` exactly when the last recorded band has width
`0`; band collapse is therefore an analytic input, never a consequence of the
recorded numbers. -/
theorem ledger_width_tendsto_zero_iff (L : List BandRecord) :
    Filter.Tendsto (fun m => ledgerHi L m - ledgerLo L m) Filter.atTop (nhds 0) ↔
      ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1) = 0 := by
  have hev : (fun m => ledgerHi L m - ledgerLo L m) =ᶠ[Filter.atTop]
      (fun _ => ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1)) := by
    filter_upwards [Filter.eventually_ge_atTop (L.length - 1)] with m hm
    exact ledger_width_eventually_const L hm
  rw [Filter.tendsto_congr' hev]
  exact tendsto_const_nhds_iff

/-! ## 5. Feeding the enclosure chain -/

section Bounded

open BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The ledger encloses the spectral edge.**  For a bounded positive
self-adjoint one-particle operator selected by the Hashimoto/Galerkin algorithm,
a well-formed ledger whose order-`m` band contains the order-`m` Ritz value
encloses `sInf (spectrum ℝ A)` at *every* order. -/
theorem ritz_band_enclosure_of_ledger [Nontrivial F] (A : F →L[ℂ] F)
    (hsa : IsSelfAdjoint A) (hpos : ∀ u : F, 0 ≤ (inner ℂ u (A u) : ℂ).re)
    (b : HilbertBasis ℕ ℂ F) {L : List BandRecord} (hwf : LedgerWf L)
    (hritz : ∀ m, ritzInf (finiteModeRestrict A b) (galerkinSpan b (m + 1)) ∈
      Set.Icc (ledgerLo L m) (ledgerHi L m)) :
    IsPositiveSelfAdjointExtension (finiteModeRestrict A b) (topRestrict A) ∧
      ∀ m, sInf (spectrum ℝ A) ∈ Set.Icc (ledgerLo L m) (ledgerHi L m) :=
  ritz_band_enclosure_of_nested A hsa hpos b (nestedBands_of_wf hwf) hritz

end Bounded

section Unbounded

open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The certified form gap read off a ledger.**  For a positive symmetric
Hamiltonian on the finite-mode core — no boundedness — a well-formed ledger whose
order-`m` band contains the order-`m` Ritz value and one of whose bands has lower
end `≥ μ` gives `⟪y, A y⟫ ≥ μ‖y‖²` on the whole domain of the Friedrichs
extension the Hashimoto shift-invert selects.  No vanishing-width hypothesis is
used, which is what makes a *finite* ledger sufficient. -/
theorem friedrichs_form_gap_of_ledger (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x)
    {L : List BandRecord} (hwf : LedgerWf L)
    (hritz : ∀ m, ritzInf H (galerkinSpan b (m + 1)) ∈
      Set.Icc (ledgerLo L m) (ledgerHi L m))
    {mu : ℝ} {m₀ : ℕ} (hlo : mu ≤ ledgerLo L m₀) :
    (∀ m, ritzInf H (finiteModeDomain b) ∈ Set.Icc (ledgerLo L m) (ledgerHi L m)) ∧
      mu ≤ ritzInf H (finiteModeDomain b) ∧
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (S : F →L[ℂ] F),
        IsPositiveSelfAdjointExtension H A ∧ IsShiftInvert A 1 S ∧ IsSelfAdjoint S ∧
          ∀ y : Dom, mu * ‖(y : F)‖ ^ 2 ≤ quadForm A y :=
  friedrichs_form_gap_of_nested_ritz_bands b H hsym hpos (nestedBands_of_wf hwf) hritz hlo

/-- The same, with the certified constant read off the ledger's first band. -/
theorem friedrichs_form_gap_of_ledger_lo_zero (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x)
    {L : List BandRecord} (hwf : LedgerWf L)
    (hritz : ∀ m, ritzInf H (galerkinSpan b (m + 1)) ∈
      Set.Icc (ledgerLo L m) (ledgerHi L m)) :
    ledgerLo L 0 ≤ ritzInf H (finiteModeDomain b) ∧
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (S : F →L[ℂ] F),
        IsPositiveSelfAdjointExtension H A ∧ IsShiftInvert A 1 S ∧ IsSelfAdjoint S ∧
          ∀ y : Dom, ledgerLo L 0 * ‖(y : F)‖ ^ 2 ≤ quadForm A y := by
  obtain ⟨-, h2, h3⟩ :=
    friedrichs_form_gap_of_ledger b H hsym hpos hwf hritz (mu := ledgerLo L 0)
      (m₀ := 0) le_rfl
  exact ⟨h2, h3⟩

end Unbounded

/-! ## 6. The wire format worked through

A three-order band stream in the emitted format.  The numbers are an
illustration of the format — the shape a refinement sequence has — not
transcribed solve output; what is *proved* about them is that they satisfy the
nested-compatibility conditions and therefore feed the enclosure chain. -/

-- The reader and the well-formedness check are evaluated by the kernel on the
-- example stream below; the default recursion depth is not enough for that.
set_option maxRecDepth 10000

/-- An emitted band stream at orders `0, 1, 2` for one and the same operator. -/
def formatExampleLedgerNdjson : String :=
  "{\"op\":\"qym3d/v1\",\"order\":0,\"lo\":0.900,\"hi\":2.400}\n" ++
  "{\"op\":\"qym3d/v1\",\"order\":1,\"lo\":1.500,\"hi\":2.100}\n" ++
  "{\"op\":\"qym3d/v1\",\"order\":2,\"lo\":1.850,\"hi\":1.960}\n"

/-- The parsed band stream. -/
def formatExampleLedger : List BandRecord :=
  [⟨"qym3d/v1".toList, 0, ⟨900, 3⟩, ⟨2400, 3⟩⟩,
   ⟨"qym3d/v1".toList, 1, ⟨1500, 3⟩, ⟨2100, 3⟩⟩,
   ⟨"qym3d/v1".toList, 2, ⟨1850, 3⟩, ⟨1960, 3⟩⟩]

/-- The reader parses the example stream to the expected records. -/
theorem formatExampleLedger_parse :
    parseLedger formatExampleLedgerNdjson = formatExampleLedger := by rfl

/-- The example ledger passes the nested-compatibility check. -/
theorem formatExampleLedger_wf : LedgerWf formatExampleLedger := by decide

/-- Hence its bands are nested in the sense `ChapterBandEnclosure` requires. -/
theorem formatExampleLedger_nested :
    NestedBands (ledgerLo formatExampleLedger) (ledgerHi formatExampleLedger) :=
  nestedBands_of_wf formatExampleLedger_wf

/-- The lower end of the example ledger's first band. -/
theorem formatExampleLedger_lo_zero : ledgerLo formatExampleLedger 0 = 0.9 := by
  norm_num [ledgerLo, loQ, recAt, formatExampleLedger, Decimal.toQ]

end BookProof.SirkBandLedger
