-- Generated from ChapterGaugeFixing.lean — theorem BookProof.GaugeFixing.s_gaugeField
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.ChapterH1
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

theorem BookProof.GaugeFixing.s_gaugeField : S.s (gaugeField S) = S.c := by sorry
