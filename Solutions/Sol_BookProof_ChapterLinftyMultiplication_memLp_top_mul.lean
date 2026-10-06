-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.memLp_top_mul
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {φ ψ : α → ℂ} (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    MemLp (fun x => φ x * ψ x) ⊤ μ := MemLp.smul (p := ⊤) (q := ⊤) (r := ⊤) hψ hφ
