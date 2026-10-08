-- Generated from ChapterG.lean — theorem BookProof.ChapterG.ghost_creat_conjTranspose
import Mathlib
import Definitions.Def_ChapterG
import Definitions.Def_ChapterNavierStokes
open BookProof.NavierStokes
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix
open MeasureTheory

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]

theorem BookProof.ChapterG.ghost_creat_conjTranspose : (ghostAnnih (A := ℂ))ᴴ = ghostCreat := by sorry
